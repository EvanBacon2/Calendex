//
//  DateEgvRequest.swift
//  Calendex
//
//  Created by Evan Bacon on 3/24/21.
//

import Foundation
import PromiseKit

struct DateEgvRequest {
    static func call(startDate: Date, endDate: Date) -> Promise<(Date, Egvs)> {
        var res: [Any] = []
        res.append(startDate)
        return Promise { seal in
            firstly {
                EgvRequest.call(startDate: startDate, endDate: endDate)
            }.done { egvs in
                res.append(egvs)
                seal.fulfill((date: res[0] as! Date, egvs: res[1] as! Egvs))
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
