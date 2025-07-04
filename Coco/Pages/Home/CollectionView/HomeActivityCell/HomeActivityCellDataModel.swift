//
//  HomeActivityCellDataModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 04/07/25.
//

import Foundation

struct HomeActivityCellDataModel: Hashable {
    let id: String
    
    let area: String
    let name: String
    let priceText: String
    let imageUrl: URL?
}

typealias HomeActivityCellSectionDataModel = (title: String?, dataModel: [HomeActivityCellDataModel])
