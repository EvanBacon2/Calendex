//
//  loginViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 3/6/21.
//

import AuthenticationServices
import PromiseKit
import CoreData
import Foundation
import SwiftUI

class LoginViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    @Published var authFlag: Bool = true
    @Published var accessFlag: Bool = false
    @Published var finishFlag: Bool = false
    
    let coreContext = PersistenceController.shared.container.viewContext
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn() {
        firstly {
            self.authorize()
        }.then { code in
            self.access(authCode: code)
        }.then {
            self.range()
        }.then { range in
            self.populate(userRange: range, lowBound: 70, highBound: 140)
        }.catch { error in
            print(error)
        }
    }
    
    private func authorize() -> Promise<String> {
        return Promise { seal in
            firstly {
                AuthorizeRequest.call(context: self)
            }.done { code in
                self.authFlag = false
                self.accessFlag = true
                seal.fulfill(code)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func access(authCode: String) -> Promise<Void> {
        return Promise { seal in
            firstly {
                TokenRequest.call(authCode: authCode)
            }.done { token in
                let tokenEntity = Token_Entity(context: self.coreContext)
                tokenEntity.access = token.access_token
                tokenEntity.expire = Date(timeInterval: TimeInterval(token.expires_in - 120), since: Date())
                tokenEntity.refresh = token.refresh_token
                
                do {
                    try self.coreContext.save()
                    seal.fulfill(())
                } catch {
                    seal.reject(error)
                }
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func range() -> Promise<DataRange> {
        return Promise { seal in
            firstly {
                DataRangeRequest.call()
            }.done { range in
                print(range.egvs!.start)
                print(range.egvs!.end)
                seal.fulfill(range)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func populate(userRange: DataRange, lowBound: Int, highBound: Int) -> Promise<Void> {
        return Promise { seal in
            firstly {
                BSSetup.populateDataBase(dataRange: userRange,
                                         lowBound: lowBound,
                                         highBound: highBound)
            }.done {
                self.accessFlag = false
                self.finishFlag = true
                seal.fulfill(())
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
