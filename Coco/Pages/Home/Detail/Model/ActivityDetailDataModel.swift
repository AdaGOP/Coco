//
//  ActivityDetailDataModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation

struct ActivityDetailDataModel {
    let title: String
    let location: String
    let imageUrlsString: [String]
    
    let detailInfomation: ActivitySectionLayout<String>
    let providerDetail: ActivitySectionLayout<ProviderDetail>
    let tripFacilities: ActivitySectionLayout<[String]>
    let tnc: ActivitySectionLayout<[String]>
    
    let availablePackages: ActivitySectionLayout<[Package]>
    
    struct ProviderDetail {
        let name: String
        let description: String
        let imageUrlString: String
    }
    
    struct Package {
        let imageUrlString: String
        let name: String
        let location: String
        let rating: String
        let price: String
    }
}

struct ActivitySectionLayout<T> {
    let title: String
    let content: T
}
