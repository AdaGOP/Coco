//
//  APIConfig.swift
//  Coco
//
//  Created by Jackie Leonardy on 30/06/25.
//

import Foundation

enum APIConfig {
    static let baseURL = "https://guffnieowbgkilwcjkks.supabase.co/rest/v1/"
}

enum Endpoint {
    case allActivities
    case users
    case activitiesByTitle(title: String)

    var path: String {
        switch self {
        case .allActivities:
            return "activities"
        case .users:
            return "users"
        case .activitiesByTitle(let title):
            return "activities?title=ilike.\(title)"
        }
    }

    var urlString: String {
        return APIConfig.baseURL + path
    }
}
