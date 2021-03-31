//
//  TokenRequest.swift
//  Calendex
//
//  Created by Evan Bacon on 3/21/21.
//

import Foundation
import PromiseKit

struct TokenRequest {
    static func getAccessToken() -> Promise<String> {
        return Promise { seal in
            let coreContext = PersistenceController.shared.container.viewContext
            
            do {
                let res = try coreContext.fetch(Token_Entity.fetchRequest())
                if let token = res.first as? Token_Entity {
                    if let access = token.access {
                        seal.fulfill(access)
                    } else {
                        firstly {
                            TokenRequest.call(refreshToken: token.refresh!)
                        }.done { newToken in
                            token.access = newToken.access_token
                            token.expire = Date(timeInterval: TimeInterval(newToken.expires_in - 120), since: Date())
                            token.refresh = newToken.refresh_token
                            seal.fulfill(token.access!)
                        }.catch { error in
                            seal.reject(error)
                        }
                    }
                }
            } catch {
                seal.reject(error)
            }
        }
    }
    
    static func call(refreshToken: String) -> Promise<AccessToken> {
        return baseCall(permission: refreshToken, type: "refresh_token", label: "refresh_token")
    }
    
    
    static func call(authCode: String) -> Promise<AccessToken> {
        return baseCall(permission: authCode, type: "authorization_code", label: "code")
    }
    
    private static func baseCall(permission: String, type: String, label: String) -> Promise<AccessToken> {
        return Promise { seal in
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
            tokenData.append("&\(label)=\(permission)".data(using: String.Encoding.utf8)!)
            tokenData.append("&grant_type=\(type)".data(using: String.Encoding.utf8)!)
            tokenData.append("&redirect_uri=calendex://".data(using: String.Encoding.utf8)!)
            
            var tokenRequest = URLRequest(url: tokenURL.url!, cachePolicy: .useProtocolCachePolicy)
            tokenRequest.httpMethod = "POST"
            tokenRequest.allHTTPHeaderFields = tokenHeaders
            tokenRequest.httpBody = tokenData as Data
            
            let task = URLSession.shared.dataTask(with: tokenRequest) { data, response, error in
                if let error = error {
                    seal.reject(error)
                    return
                } else {
                    do {
                        let decoder = JSONDecoder()
                        let accessToken = try decoder.decode(AccessToken.self, from: data!)
                        seal.fulfill(accessToken)
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
