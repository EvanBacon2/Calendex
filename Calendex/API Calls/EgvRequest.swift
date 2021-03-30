//
//  EgvRequest.swift
//  Calendex
//
//  Created by Evan Bacon on 3/23/21.
//

import Foundation
import PromiseKit

struct EgvRequest {
    static func call(startDate: Date, endDate: Date) -> Promise<Egvs> {
        return Promise { seal in
            firstly {
                TokenRequest.getAccessToken()
            }.then { token in
                EgvRequest.request(token, startDate, endDate)
            }.done { Egvs in
                seal.fulfill(Egvs)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private static func request(_ token: String, _ startDate: Date, _ endDate: Date) -> Promise<Egvs> {
        return Promise { seal in
            let egvHeaders = [
              "authorization": "Bearer \(token)",
            ]
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            var egvURL = URLComponents()
            egvURL.scheme = "https"
            egvURL.host = "sandbox-api.dexcom.com"
            egvURL.path = "/v2/users/self/egvs"
            egvURL.queryItems = [
                URLQueryItem(name: "startDate", value: formatter.string(from: startDate)),
                URLQueryItem(name: "endDate", value: formatter.string(from: endDate))
            ]
            
            var egvRequest = URLRequest(url: egvURL.url!)
            egvRequest.httpMethod = "GET"
            egvRequest.allHTTPHeaderFields = egvHeaders
            
            let task = URLSession.shared.dataTask(with: egvRequest) { data, response, error in
              if let error = error {
                seal.reject(error)
                return
              } else {
                do {
                    let decoder = JSONDecoder()
                    let egvs = try decoder.decode(Egvs.self, from: data!)
                    seal.fulfill(egvs)
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
