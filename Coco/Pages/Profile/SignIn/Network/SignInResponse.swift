//
//  SignInResponse.swift
//  Coco
//
//  Created by Jackie Leonardy on 16/07/25.
//

import Foundation

struct SignInResponse: JSONDecodable {
    let userId: String
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}
