//
//  DateInfoViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/6/21.
//

import Combine
import CoreData
import CoreGraphics
import Foundation

class DateInfoViewModel: ObservableObject {
    let coreContext = PersistenceController.shared.container.viewContext
    //made static so as not to create unessecary extra threads
    static let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    let emptyDistribution: [CGFloat] = Array(repeating: 0, count: 36)
    
    let fetchSubject = PassthroughSubject<Date_Info_Entity?, Never>()
    var cancellables: [AnyCancellable] = []
    
    @Published var dateInfo: Date_Info_Entity? = nil
    
    let year: Int
    let month: Int
    let day: Int
    
    init(year: Int = -1, month: Int = -1, day: Int = -1) {
        self.year = year
        self.month = month
        self.day = day
        
        print("info init \(year), \(month), \(day)")
        DateInfoViewModel.privateContext.parent = DateButtonViewModel.coreContext
        cancellables.append(fetchSubject
                                .receive(on: RunLoop.main)
                                .sink { info in
                                    self.dateInfo = info
                                })
        DateInfoViewModel.fetchDate(year: year, month: month, day: day, datePub: fetchSubject)
    }
    
    func setDate(year: Int = -1, month: Int = -1, day: Int = -1) {
        DateInfoViewModel.fetchDate(year: year, month: month, day: day, datePub: fetchSubject)
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
    
    func getRange(_ range: Range, lowBound: Int, highBound: Int) -> CGFloat {
        if let info = dateInfo {
            let dis = info.info?.distribution ?? []
            switch range {
            case .low:
                return dis[0..<thToI(lowBound)].reduce(0, { sum, val in sum + val.value }) * 100
            case .mid:
                return dis[thToI(lowBound)..<thToI(highBound)].reduce(0, { sum, val in sum + val.value }) * 100
            case .high:
                return dis[thToI(highBound)..<dis.count].reduce(0, { sum, val in sum + val.value }) * 100
            }
        } else {
            return 0
        }
    }
    
    func thToI(_ threshold: Int) -> Int {
        return (threshold / 10) - 4
    }
}
