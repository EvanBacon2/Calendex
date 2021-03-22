//
//  TokenRequest.swift
//  Calendex
//
//  Created by Evan Bacon on 3/21/21.
//

import Foundation

struct TokenRequest {
    static func call(authCode: String) -> Void {
        let tokenHeaders = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        
        var tokenURL = URLComponents()
        tokenURL.scheme = "https"
        tokenURL.host = "sandbox-api.dexcom.com"
        tokenURL.path = "/v2/oauth2/token"
        
        let tokenData = NSMutableData()
        tokenData.append("client_secret=bnezGihDqAkZOHho".data(using: String.Encoding.utf8)!)
        tokenData.append("&client_id=xMJNMZkfJcz8UKxLg7co5pjQ6sHrnaB0".data(using: String.Encoding.utf8)!)
        tokenData.append("&code=\(authCode)".data(using: String.Encoding.utf8)!)
        tokenData.append("&grant_type=authorization_code".data(using: String.Encoding.utf8)!)
        tokenData.append("&redirect_uri=calendex://".data(using: String.Encoding.utf8)!)
        
        var tokenRequest = URLRequest(url: tokenURL.url!, cachePolicy: .useProtocolCachePolicy)
        tokenRequest.httpMethod = "POST"
        tokenRequest.allHTTPHeaderFields = tokenHeaders
        tokenRequest.httpBody = tokenData as Data
        
        let task = URLSession.shared.dataTask(with: tokenRequest) { data, response, error in
            if let error = error {
                print(error)
            } else {
                do {
                    let decoder = JSONDecoder()
                    let accessToken = try decoder.decode(AccessToken.self, from: data!)
                    print(accessToken.access_token)
                } catch {
                    print("json error")
                }
            }
        }
        
        task.resume()
    }
}
