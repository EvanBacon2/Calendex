//
//  BSSetup.swift
//  Calendex
//
//  Created by Evan Bacon on 3/29/21.
//

import Foundation
import PromiseKit
import CoreData

struct BSSetup {
    static let coreContext = PersistenceController.shared.container.viewContext
    
    static func populateDataBase(dataRange: DataRange, lowBound: Int, highBound: Int) -> Promise<Bool> {
        return Promise { seal in
            var cal = Calendar.current
            cal.timeZone = TimeZone(identifier: "UTC")!
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            var startDate = formatter.date(from: dataRange.egvs!.start.systemTime)!
            var endDate = formatter.date(from: dataRange.egvs!.end.systemTime)!
            let startComp = cal.dateComponents([.day, .month, .year], from: startDate)
            let endComp = cal.dateComponents([.day, .month, .year], from: endDate)
            startDate = cal.date(from: startComp)!
            endDate = cal.date(from: endComp)!
            
            var dates: [Date] = []
            
            var currDate = startDate
            while (currDate <= endDate) {
                dates.append(currDate)
                currDate = cal.date(byAdding: .day, value: 1, to: currDate)!
            }
            
            when(fulfilled: dates.map { DateEgvRequest.call(startDate: $0,
                                                            endDate: cal.date(byAdding: .day, value: 1, to: $0)!)
            }).done { results in
                for res in results {
                    self.createDate(date: cal.dateComponents([.day, .month, .year], from: res.0),
                                    info: self.getInfoFromEgvs(egvs: res.1,
                                                               lowBound: lowBound,
                                                               highBound: highBound))
                }
                
                var currMonth = startDate
                while (currMonth <= endDate) {
                    let month = cal.dateComponents([.month, .year], from: currMonth)
                    self.createDate(date: month,
                                    info: self.getInfoFromCore(fetchType: "month",
                                                               date: month,
                                                               lowBound: lowBound,
                                                               highBound: highBound))
                    currMonth = cal.date(byAdding: .month, value: 1, to: currMonth)!
                }
                
                var currYear = startDate
                while (currYear <= endDate) {
                    let year = cal.dateComponents([.year], from: currYear)
                    self.createDate(date: year,
                                    info: self.getInfoFromCore(fetchType: "year",
                                                               date: year,
                                                               lowBound: lowBound,
                                                               highBound: highBound))
                    currYear = cal.date(byAdding: .year, value: 1, to: currYear)!
                }
                
                seal.fulfill(true)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private static func createDate(date: DateComponents, info: Bg_Info_Entity) {
        let dateEntity = Date_Info_Entity(context: self.coreContext)
        
        dateEntity.year = date.year ?? -1
        dateEntity.month = date.month ?? -1
        dateEntity.day = date.day ?? -1
        dateEntity.date_info = info
    }
    
    private static func getInfoFromEgvs(egvs: Egvs, lowBound: Int, highBound: Int) -> Bg_Info_Entity {
        let info = Bg_Info_Entity(context: self.coreContext)
        
        info.info_mea = Measures_Entity(context: self.coreContext)
        info.info_dis = Distribution_Entity(context: self.coreContext)
        info.entries = egvs.egvs.count
        
        let measures = info.info_mea!
        let distribution = info.info_dis!
        
        let entries = egvs.egvs.count
        
        info.entries = entries
        measures.mean = CGFloat(egvs.egvs.reduce(0.0, { sum, val in sum + val.value })) / CGFloat(entries)
        measures.stdDeviation = CGFloat(
            sqrt(egvs.egvs.reduce(0.0, { dev, val in pow(val.value - Double(measures.mean), 2) }) / Double(entries)))
        measures.min = egvs.egvs.reduce(Int(INT_MAX), { min, val  in Int(val.value) < min ? Int(val.value) : min })
        measures.max = egvs.egvs.reduce(Int(-INT_MAX - 1), { max, val in Int(val.value) > max ? Int(val.value) : max })
    
        var distCounts = Array(repeating: 0, count: 36)
        
        for egv in egvs.egvs {
            var val = egv.value
            val = val < 40 ? val + 1 : val
            val = val > 400 ? val - 1 : val
            val /= 10.0
            var valRange = Int(floor(val))
            valRange = valRange == 36 ? valRange - 1 : valRange
            distCounts[valRange - 4] += 1
        }
        
        let distSum: Float = Float(distCounts.reduce(0, +))
        let distRanges = (4...39).map { range -> DistributionRange_Entity in
            let rangeEntity = DistributionRange_Entity(context: self.coreContext)
            rangeEntity.range = range * 10
            rangeEntity.value = CGFloat(distCounts[range - 4]) / CGFloat(distSum)
            return rangeEntity
        }
        
        for distRange in distRanges {
            distribution.addToDis_disRange(distRange)
        }
        
        return info
    }
    
    private static func getInfoFromCore(fetchType: String, date: DateComponents, lowBound: Int, highBound: Int) -> Bg_Info_Entity {
        var fetchRes: [Date_Info_Entity] = []
        
        do {
            if fetchType == "month" {
                fetchRes = try self.coreContext.fetch(Fetches.fetchDaysInMonth(year: date.year!, month: date.month!))
            } else if fetchType == "year" {
                fetchRes = try self.coreContext.fetch(Fetches.fetchMonthsInYear(year: date.year!))
            }
        } catch {
            print(error)
        }
        
        let info = Bg_Info_Entity(context: self.coreContext)
        
        info.info_mea = Measures_Entity(context: self.coreContext)
        info.info_dis = Distribution_Entity(context: self.coreContext)
        
        let measures = info.info_mea!
        let distribution = info.info_dis!
    
        var distCounts: [Float] = Array(repeating: 0, count: 36)
        
        for res in fetchRes {
            if let resInfo = res.date_info {
                info.entries += resInfo.entries
                measures.min = resInfo.info_mea!.min < measures.min ? resInfo.info_mea!.min : measures.min
                measures.max = resInfo.info_mea!.max > measures.max ? resInfo.info_mea!.max : measures.max
                measures.mean += resInfo.info_mea!.mean * CGFloat(resInfo.entries)
                measures.stdDeviation += pow(resInfo.info_mea!.stdDeviation * CGFloat(resInfo.entries), 2)
                
                distCounts = zip(distCounts, resInfo.info_dis!.distribution).map { $0 + Float($1.value) }
            }
        }
        
        measures.mean /= CGFloat(info.entries)
        measures.stdDeviation = sqrt(measures.stdDeviation / CGFloat(info.entries))
        
        let distSum = distCounts.reduce(0, +)
        let distVals = distCounts.map { CGFloat($0 / distSum) }
        let distRanges = (4...39).map { range -> DistributionRange_Entity in
            let rangeEntity = DistributionRange_Entity(context: self.coreContext)
            rangeEntity.range = range * 10
            rangeEntity.value = distVals[range - 4]
            return rangeEntity
        }
        
        for distRange in distRanges {
            distribution.addToDis_disRange(distRange)
        }
        
        return info
    }
}
