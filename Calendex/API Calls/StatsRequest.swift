//
//  StatsRequest.swift
//  Calendex
//
//  Created by Evan Bacon on 3/21/21.
//

import Foundation
import PromiseKit

struct StatsRequest {
    static func call(startDate: Date, endDate: Date, lowBound: Int, highBound: Int) -> Promise<Stats> {
        return Promise { seal in
            firstly {
                TokenRequest.getAccessToken()
            }.then { token in
                StatsRequest.request(token, startDate, endDate, lowBound, highBound)
            }.done { stats in
                seal.fulfill(stats)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private static func request(_ token: String, _ startDate: Date, _ endDate: Date, _ lowBound: Int, _ highBound: Int) -> Promise<Stats> {
        return Promise { seal in
            let statHeaders = [
              "authorization": "Bearer \(token)",
              "content-type": "application/json"
            ]
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            var statURL = URLComponents()
            statURL.scheme = "https"
            statURL.host = "sandbox-api.dexcom.com"
            statURL.path = "/v2/users/self/statistics"
            statURL.queryItems = [
                URLQueryItem(name: "startDate", value: formatter.string(from: startDate)),
                URLQueryItem(name: "endDate", value: formatter.string(from: endDate))
            ]
            
            let body = ["targetRanges":
                [
                    [
                        "name": "day",
                        "startTime": "00:00:00",
                        "endTime": "00:00:00",
                        "egvRanges": [
                            ["name": "urgentLow", "bound": 55],
                            ["name": "low", "bound": lowBound],
                            ["name": "high", "bound": highBound]
                        ]
                    ]
                ]
            ] as [String : Any]

            let statBody = try JSONSerialization.data(withJSONObject: body, options: [])
    
            var statRequest = URLRequest(url: statURL.url!, cachePolicy: .useProtocolCachePolicy)
            statRequest.httpMethod = "POST"
            statRequest.allHTTPHeaderFields = statHeaders
            statRequest.httpBody = statBody as Data

            let task = URLSession.shared.dataTask(with: statRequest) { data, response, error in
              if let error = error {
                seal.reject(error)
                return
              } else {
                do {
                    let decoder = JSONDecoder()
                    let stats = try decoder.decode(Stats.self, from: data!)
                    seal.fulfill(stats)
                    return
                } catch {
                    seal.reject(error)
                    return
                }
              }
            }

            task.resume()
        }
    }
}
