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
    let hiddenPackages: [Package]
    
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
    
    init(_ response: Activity) {
        title = response.title
        location = response.destination.name
        imageUrlsString = response.images.map { $0.imageUrl }
        
        detailInfomation = ActivitySectionLayout(
            title: "Details",
            content: response.description
        )
        providerDetail = ActivitySectionLayout(
            title: "Trip Provider",
            content: ProviderDetail(
                name: response.destination.name,
                description: response.destination.description,
                imageUrlString: response.destination.imageUrl ?? ""
            )
        )
        tripFacilities = ActivitySectionLayout(
            title: "This Trip Includes",
            content: response.accessories.map { $0.name }
        )
        tnc = ActivitySectionLayout(
            title: "Terms and Condition",
            content: [] // TODO: Wiring
        )
        
        availablePackages = ActivitySectionLayout(
            title: "Available Packages",
            content: response.packages.map {
                Package(
                    imageUrlString: "https://picsum.photos/id/237/600/341", // TODO: WIRING
                    name: $0.name,
                    location: "TODO", // TODO: WIRING
                    rating: "TODO", // TODO: WIRING
                    price: "\($0.pricePerPerson)"
                )
            }
        )
        
        hiddenPackages = Array(availablePackages.content.prefix(1))
    }
}

struct ActivitySectionLayout<T> {
    let title: String
    let content: T
}
