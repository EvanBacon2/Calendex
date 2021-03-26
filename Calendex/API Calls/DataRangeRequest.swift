//
//  DataRangeRequest.swift
//  Calendex
//
//  Created by Evan Bacon on 3/22/21.
//

import Foundation
import PromiseKit

struct DataRangeRequest {
    static func call(token: String) -> Promise<DataRange> {
        return Promise { seal in
            let rangeHeaders = [
              "authorization": "Bearer \(token)",
            ]
            
            var rangeURL = URLComponents()
            rangeURL.scheme = "https"
            rangeURL.host = "sandbox-api.dexcom.com"
            rangeURL.path = "/v2/users/self/dataRange"
            
            var rangeRequest = URLRequest(url: rangeURL.url!, cachePolicy: .useProtocolCachePolicy)
            rangeRequest.httpMethod = "GET"
            rangeRequest.allHTTPHeaderFields = rangeHeaders
            
            let task = URLSession.shared.dataTask(with: rangeRequest) { data, response, error in
              if let error = error {
                seal.reject(error)
                return
              } else {
                do {
                    let decoder = JSONDecoder()
                    let dataRange = try decoder.decode(DataRange.self, from: data!)
                    seal.fulfill(dataRange)
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
