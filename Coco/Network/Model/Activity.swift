//
//  Activity.swift
//  Coco
//
//  Created by Jackie Leonardy on 01/07/25.
//

import Foundation

struct Activity: JSONDecodable {
    let categoryid: Int
    let createdAt: String
    let description: String
    let destinationid: Int
    let durationMinutes: Int
    let id: Int
    let pricing: Double
    let thumbnailurl: String?
    let title: String

    private enum CodingKeys: String, CodingKey {
        case categoryid = "category_id"
        case createdAt = "created_at"
        case description
        case destinationid = "destination_id"
        case durationMinutes = "duration_minutes"
        case id, pricing
        case thumbnailurl = "thumbnail_url"
        case title
    }
}

typealias ActivityModelArray = JSONArray<Activity>
