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
        
        let year: Int32 = 2021
        let monthDays: [Int32] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        let yearEntity = Date_Info_Entity(context: controller.container.viewContext)
        yearEntity.year_attr = year
        yearEntity.month_attr = -1
        yearEntity.day_attr = -1
        yearEntity.date_info!.entries_attr = 365
        yearEntity.date_info = getBgInfo(controller)
        
        for month: Int32 in 1...12 {
            let monthEntity = Date_Info_Entity(context: controller.container.viewContext)
            monthEntity.year_attr = 2021
            monthEntity.month_attr = month
            monthEntity.day_attr = -1
            monthEntity.date_info!.entries_attr = monthDays[Int(month - 1)]
            monthEntity.date_info = getBgInfo(controller)
            
            for day: Int32 in 1...monthDays[Int(month) - 1] {
                let dayEntity = Date_Info_Entity(context: controller.container.viewContext)
                dayEntity.year_attr = 2021
                dayEntity.month_attr = month
                dayEntity.day_attr = day
                dayEntity.date_info!.entries_attr = 1
                dayEntity.date_info = getBgInfo(controller)
            }
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
        infoEntity.info_mea?.mean_attr = Float([62.0, 112.0, 194.0].randomElement()!)
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
        var vals = (1...36).map { _ in Float.random(in: 0...100) }
        let sum: Float = vals.reduce(0, { x, y in x + y })
        vals = vals.map { $0 / (sum * 0.01) }
        let distRanges = (4...39).map { i ->
            DistributionRange_Entity in let r = DistributionRange_Entity(context: controller.container.viewContext)
            r.range_attr = Int32(i * 10)
            r.value_attr = vals[i - 4]
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
