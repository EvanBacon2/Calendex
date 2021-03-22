//
//  AcessToken.swift
//  Calendex
//
//  Created by Evan Bacon on 3/21/21.
//

import Foundation

struct AccessToken: Codable {
    var access_token: String
    var expires_in: Int
    var refresh_token: String
    var token_type: String
}
