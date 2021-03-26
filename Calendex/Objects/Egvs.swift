//
//  Egvs.swift
//  Calendex
//
//  Created by Evan Bacon on 3/23/21.
//

import Foundation

struct Egvs: Codable {
    var unit: String
    var rateUnit: String
    var egvs: [Egv]
}

struct Egv: Codable {
    var systemTime: String
    var displayTime: String
    var value: Double
    var realtimeValue: Double
    var smoothedValue: Double?
    var status: String?
    var trend: String?
    var trendRate: Double?
}
