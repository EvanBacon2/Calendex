//
//  DateInfoRequest.swift
//  Calendex
//
//  Created by Evan Bacon on 3/24/21.
//

import Foundation
import PromiseKit

struct DateInfoRequest {
    static func call(token: String, startDate: Date, endDate: Date, lowBound: Int, highBound: Int) -> Promise<(Date, Stats, Egvs)> {
        var res: [Any] = []
        res.append(startDate)
        
        return Promise { seal in
            firstly {
                StatsRequest.call(token: token,
                                  startDate: startDate,
                                  endDate: endDate,
                                  lowBound: lowBound,
                                  highBound: highBound)
            }.done { stats in
                res.append(stats)
            }.then {
                EgvRequest.call(token: token,
                                startDate: startDate,
                                endDate:endDate)
            }.done { egvs in
                res.append(egvs)
                seal.fulfill((date: res[0] as! Date, stats: res[1] as! Stats, egvs: res[2] as! Egvs))
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
