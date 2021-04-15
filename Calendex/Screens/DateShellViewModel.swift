//
//  DateShellViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/15/21.
//

import CoreData
import Foundation
import SwiftUI

protocol DateShellViewModel {
    func getTitle(date: Int) -> String
    func startDate() -> Int
    func endDate() -> Int
    func nDates() -> Int
}
