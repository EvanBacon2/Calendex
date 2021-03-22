//
//  SignInRequest.swift
//  Calendex
//
//  Created by Evan Bacon on 3/21/21.
//

import Foundation
import AuthenticationServices

struct SignInRequest {
    static func call(context: ASWebAuthenticationPresentationContextProviding) -> Void {
        var authURL = URLComponents()
        authURL.scheme = "https"
        authURL.host = "sandbox-api.dexcom.com"
        authURL.path = "/v2/oauth2/login"
        authURL.queryItems = [
            URLQueryItem(name: "client_id", value: "xMJNMZkfJcz8UKxLg7co5pjQ6sHrnaB0"),
            URLQueryItem(name: "redirect_uri", value: "calendex://"),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: "offline_access")
        ]
        let scheme = "calendex"
        
        let session = ASWebAuthenticationSession(url: authURL.url!, callbackURLScheme: scheme)
        { callbackURL, error in
            if let error = error {
                print(error)
            } else {
                let authCode = URLComponents(url: callbackURL!, resolvingAgainstBaseURL: true)?.queryItems![0].value!
                TokenRequest.call(authCode: authCode!)
            }
        }
        
        session.presentationContextProvider = context
        session.prefersEphemeralWebBrowserSession = true
        
        session.start()
    }
}
