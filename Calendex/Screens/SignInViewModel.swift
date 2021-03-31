//
//  SignInViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 3/6/21.
//

import AuthenticationServices
import PromiseKit
import CoreData
import Foundation

class SignInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    let coreContext = PersistenceController.shared.container.viewContext
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn() -> Promise<DataRange> {
        return Promise { seal in
            firstly {
                SignInRequest.call(context: self)
            }.then { authCode in
                TokenRequest.call(authCode: authCode)
            }.done { token in
                let tokenEntity = Token_Entity(context: self.coreContext)
                tokenEntity.access = token.access_token
                tokenEntity.expire = Date(timeInterval: TimeInterval(token.expires_in - 120), since: Date())
                tokenEntity.refresh = token.refresh_token
                do {
                    try self.coreContext.save()
                } catch {
                    seal.reject(error)
                }
            }.then {
                DataRangeRequest.call()
            }.done { range in
                seal.fulfill(range)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
