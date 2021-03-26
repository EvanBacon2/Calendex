//
//  DataRange.swift
//  Calendex
//
//  Created by Evan Bacon on 3/22/21.
//

import Foundation

struct DataRange: Codable {
    var calibrations: data_range?
    var egvs: data_range?
    var events: data_range?
}

struct data_range: Codable {
    var start: time_entry
    var end: time_entry
}

struct time_entry: Codable {
    var systemTime: String
    var displayTime: String
}
