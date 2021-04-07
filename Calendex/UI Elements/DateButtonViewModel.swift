//
//  DateButtonViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/6/21.
//

import Combine
import CoreData
import CoreGraphics
import Foundation

class DateButtonViewModel: ObservableObject {
    static let coreContext = PersistenceController.shared.container.viewContext
    static let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    @Published var dateInfo: Date_Info_Entity? = nil
    
    let fetchSubject = PassthroughSubject<Date_Info_Entity?, Never>()
    var cancellables: [AnyCancellable] = []
    
    init(year: Int = -1, month: Int = -1, day: Int = -1) {
        DateButtonViewModel.privateContext.parent = DateButtonViewModel.coreContext
        cancellables.append(fetchSubject
                                .receive(on: RunLoop.main)
                                .sink { info in
                                    self.dateInfo = info
                                })
        DateButtonViewModel.fetchDate(year: year, month: month, day: day, datePub: fetchSubject)
    }
    
    static private func fetchDate(year: Int, month: Int, day: Int, datePub: PassthroughSubject<Date_Info_Entity?, Never>) {
        var info: Date_Info_Entity? = nil
        privateContext.perform {
            do {
                info = try self.privateContext.fetch(Fetches.fetchDateInfo(year: year, month: month, day: day)).first
                datePub.send(info)
            } catch {
                print(error)
            }
        }
    }
    
    func dateHasData() -> Bool {
        return (dateInfo?.info?.entries ?? 0) > 0
    }
    
    func getAvgRange(lowBound: Int, highBound: Int) -> Range {
        let mean = dateInfo?.info?.measures?.mean ?? 0.0
        
        if (mean <= CGFloat(lowBound)) {
            return .low
        } else if (mean >= CGFloat(highBound)) {
            return .high
        } else {
            return .mid
        }
    }
    
    func getTimeRange(timeBound: Int, lowBound: Int, highBound: Int) -> Range {
        let midRanges = (dateInfo?.info?.distribution?[thToI(lowBound)..<thToI(highBound)] ?? [])
        let midSum = midRanges.reduce(0, { sum, val in sum + val.value }) * 100
        
        if (midSum >= CGFloat(timeBound)) {
            return .mid
        } else {
            return .high
        }
    }
    
    func getStdDevRange(devBound: Int) -> Range {
        let deviation = dateInfo?.info?.measures?.stdDeviation ?? 0.0
        
        if (deviation <= CGFloat(devBound)) {
            return .mid
        } else {
            return .high
        }
    }
    
    func thToI(_ threshold: Int) -> Int {
        return (threshold / 10) - 4
    }
}
