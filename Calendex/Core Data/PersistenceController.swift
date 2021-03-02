//
//  PersistenceController.swift
//  Calendex
//
//  Created by Evan Bacon on 2/27/21.
//

import CoreData
import CoreGraphics

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        let cal = Calendar.current
        var dates: [DateComponents] = []
        let year = DateComponents(year: 2020)
        let months = (1...12).map { month in DateComponents(year: 2020, month: month) }
        var days: [DateComponents] = []
        let monthDays = months.map { month in Array(cal.range(of: .day, in: .month, for: cal.date(from: month)!)!)
            .map { day in DateComponents(year: 2020, month: month.month, day: day) } }
        for daysInMonth in monthDays {
            days.append(contentsOf: daysInMonth)
        }
        
        let yearEntity = Date_Info_Entity(context: controller.container.viewContext)
        yearEntity.start_date_attr = cal.date(from: year)!
        yearEntity.end_date_attr = cal.date(byAdding: .year, value: 1, to: yearEntity.start_date_attr!)!
        yearEntity.date_info = getBgInfo(controller)
        
        for month in months {
            let monthEntity = Date_Info_Entity(context: controller.container.viewContext)
            monthEntity.start_date_attr = cal.date(from: month)!
            monthEntity.end_date_attr = cal.date(byAdding: .month, value: 1, to: monthEntity.start_date_attr!)!
            monthEntity.date_info = getBgInfo(controller)
        }
        
        for day in days {
            let dayEntity = Date_Info_Entity(context: controller.container.viewContext)
            dayEntity.start_date_attr = cal.date(from: day)!
            dayEntity.end_date_attr = cal.date(byAdding: .day, value: 1, to: dayEntity.start_date_attr!)!
            dayEntity.date_info = getBgInfo(controller)
        }

        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "BloodSugar")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    static func getBgInfo(_ controller: PersistenceController) -> Bg_Info_Entity {
        let infoEntity = Bg_Info_Entity(context: controller.container.viewContext)
        
        infoEntity.info_mea = Measures_Entity(context: controller.container.viewContext)
        infoEntity.info_mea?.mean_attr = Float([82.0, 112.0, 194.0].randomElement()!)
        infoEntity.info_mea?.stdDeviation_attr = Float([12.0, 32.0, 54.0].randomElement()!)
        infoEntity.info_mea?.min_attr = Int32([43, 61, 93].randomElement()!)
        infoEntity.info_mea?.max_attr = Int32([136, 176, 232].randomElement()!)
            
        infoEntity.info_tir = TimeInRange_Entity(context: controller.container.viewContext)
        infoEntity.info_tir?.lowTime_attr = 12.0
        infoEntity.info_tir?.midTime_attr = 72.0
        infoEntity.info_tir?.highTime_attr = 16.0
            
        let distRanges = getDistRanges(controller)
            
        infoEntity.info_dis = Distribution_Entity(context: controller.container.viewContext)
        for distRange in distRanges {
            infoEntity.info_dis?.addToDis_disRange(distRange)
        }
        
        return infoEntity
    }
    
    static func getDistRanges(_ controller: PersistenceController) -> [DistributionRange_Entity] {
        var vals = (1...36).map { _ in CGFloat.random(in: 0...1) }
        let sum: CGFloat = vals.reduce(0, { x, y in x + y })
        vals = vals.map { $0 / sum }
        let distRanges = (4...40).map { i ->
            DistributionRange_Entity in let r = DistributionRange_Entity(context: controller.container.viewContext)
            r.range_attr = Int32(i * 10)
            r.value_attr = Float(vals[i - 4])
            return r
        }
        
        return distRanges
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
