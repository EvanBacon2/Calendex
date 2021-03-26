//
//  Stats.swift
//  Calendex
//
//  Created by Evan Bacon on 3/22/21.
//

import Foundation

struct Stats: Codable {
    var hypoglycemiaRisk: String?
    var min: Double
    var max: Double
    var mean: Double
    var median: Double
    var variance: Double
    var stdDev: Double
    var sum: Double
    var q1: Double
    var q2: Double
    var q3: Double
    var utilizationPercent: Double
    var meanDailyCalibrations: Double
    var nDays: Int
    var nValues: Int
    var nUrgentLow: Int
    var nBelowRange: Int
    var nWithinRange: Int
    var nAboveRange: Int
    var percentUrgentLow: Double
    var percentBelowRange: Double
    var percentWithinRange: Double
    var percentAboveRange: Double
}
