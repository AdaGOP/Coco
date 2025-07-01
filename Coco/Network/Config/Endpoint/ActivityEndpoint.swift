//
//  ActivityEndpoint.swift
//  Coco
//
//  Created by Jackie Leonardy on 01/07/25.
//

import Foundation

enum ActivityEndpoint: EndpointProtocol {
    case all
    case byTitle(String)

    var path: String {
        switch self {
        case .all:
            return "activities"
        case .byTitle(let title):
            let encoded: String = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? title
            return "activities?title=ilike.\(encoded)"
        }
    }
}
