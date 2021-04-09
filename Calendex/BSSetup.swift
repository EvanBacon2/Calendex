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
    let coreContext: NSManagedObjectContext
    
    let cal: Calendar
    let formatter: DateFormatter
    
    let lowBound: Int
    let highBound: Int
    
    init(lowBound: Int, highBound: Int) {
        self.coreContext = PersistenceController.shared.container.viewContext
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        self.cal = calendar
        
        self.formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        self.lowBound = lowBound
        self.highBound = highBound
    }
    
    func populateDataBase(dataRange: DataRange) -> Promise<Void> {
        return Promise { seal in
            var startDate = formatter.date(from: dataRange.egvs!.start.systemTime)!
            var endDate = formatter.date(from: dataRange.egvs!.end.systemTime)!
            let startComp = cal.dateComponents([.day, .month, .year], from: startDate)
            let endComp = cal.dateComponents([.day, .month, .year], from: endDate)
            startDate = cal.date(from: startComp)!
            endDate = cal.date(from: endComp)!
            
            let metaEntity = Meta_Entity(context: coreContext)
            metaEntity.startYear = startComp.year!
            metaEntity.startMonth = startComp.month!
            metaEntity.startDay = startComp.day!
            metaEntity.endYear = endComp.year!
            metaEntity.endMonth = endComp.month!
            metaEntity.endDay = endComp.day!
            
            var dates: [Date] = [startDate]
            
            var currDate = startDate
            while let nextDate = cal.date(byAdding: .day, value: 90, to: currDate), nextDate <= endDate {
                dates.append(nextDate)
                currDate = nextDate
            }
            
            when(fulfilled: dates.map { fillDayBlock(startDate: $0,
                                                     endDate: cal.date(byAdding: .day, value: 90, to: $0)!)
            }).done {
                var currMonth = cal.date(from: DateComponents(year: startComp.year!, month: startComp.month))!
                while (currMonth <= endDate) {
                    let month = cal.dateComponents([.month, .year], from: currMonth)
                    self.createDate(date: month, info: self.getInfoFromCore(fetchType: "month", date: month))
                    currMonth = cal.date(byAdding: .month, value: 1, to: currMonth)!
                }
                
                var currYear = cal.date(from: DateComponents(year: startComp.year!))!
                while (currYear <= endDate) {
                    let year = cal.dateComponents([.year], from: currYear)
                    self.createDate(date: year, info: self.getInfoFromCore(fetchType: "year", date: year))
                    currYear = cal.date(byAdding: .year, value: 1, to: currYear)!
                }
                
                seal.fulfill(())
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func fillDayBlock(startDate: Date, endDate: Date) -> Promise<Void> {
        return Promise { seal in
            firstly {
                DateEgvRequest.call(startDate: startDate, endDate: endDate)
            }.done { res in
                var cal = Calendar.current
                cal.timeZone = TimeZone(identifier: "UTC")!
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                var index = res.1.egvs.count - 1
                var startIndex = res.1.egvs.count - 1
                var currDay = formatter.date(from: res.1.egvs[res.1.egvs.count - 1].systemTime)!
                let dayComp = cal.dateComponents([.day, .month, .year], from: currDay)
                currDay = cal.date(from: dayComp)!
                print(currDay)
                var dayCutoff = cal.date(byAdding: .day, value: 1, to: currDay)!
                while index >= 0 {
                    index -= 290
                    if index < 0 {
                        index = 0
                    }
                    
                    while let indexDate = formatter.date(from: res.1.egvs[index].systemTime), indexDate > dayCutoff {
                        index += 1
                    }
                    
                    self.createDate(date: cal.dateComponents([.day, .month, .year], from: currDay),
                                    info: self.getInfoFromEgvs(egvs: res.1.egvs[index..<startIndex]))
                    
                    startIndex = index - 1
                    index -= 1
                    currDay = dayCutoff
                    dayCutoff = cal.date(byAdding: .day, value: 1, to: dayCutoff)!
                }
                
                seal.fulfill(())
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func createDate(date: DateComponents, info: Bg_Info_Entity) {
        let dateEntity = Date_Info_Entity(context: self.coreContext)
        
        dateEntity.year = date.year ?? -1
        dateEntity.month = date.month ?? -1
        dateEntity.day = date.day ?? -1
        dateEntity.date_info = info
    }
    
    private func getInfoFromEgvs(egvs: ArraySlice<Egv>) -> Bg_Info_Entity {
        let info = Bg_Info_Entity(context: self.coreContext)
        info.info_mea = Measures_Entity(context: self.coreContext)
        info.info_dis = Distribution_Entity(context: self.coreContext)
        info.entries = egvs.count
        
        let measures = info.info_mea!
        let distribution = info.info_dis!
        
        let entries = egvs.count
        
        info.entries = entries
        measures.mean = CGFloat(egvs.reduce(0.0, { sum, val in sum + val.value })) / CGFloat(entries)
        measures.stdDeviation = CGFloat(
            sqrt(egvs.reduce(0.0, { dev, val in pow(val.value - Double(measures.mean), 2) }) / Double(entries)))
        measures.min = egvs.reduce(Int(INT_MAX), { min, val  in Int(val.value) < min ? Int(val.value) : min })
        measures.max = egvs.reduce(Int(-INT_MAX - 1), { max, val in Int(val.value) > max ? Int(val.value) : max })
    
        var distCounts = Array(repeating: 0, count: 36)
        
        for egv in egvs {
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
    
    private func getInfoFromCore(fetchType: String, date: DateComponents) -> Bg_Info_Entity {
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
