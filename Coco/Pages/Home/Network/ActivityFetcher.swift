//
//  ActivityFetcher.swift
//  Coco
//
//  Created by Jackie Leonardy on 01/07/25.
//

import Foundation

protocol ActivityFetcherProtocol: AnyObject {
    func fetchActivity(
        request: ActivitySearchRequest,
        endpoint: ActivityEndpoint,
        completion: @escaping (Result<ActivityModelArray, NetworkServiceError>) -> Void
    )
}

final class ActivityFetcher: ActivityFetcherProtocol {
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchActivity(
        request: ActivitySearchRequest,
        endpoint: ActivityEndpoint,
        completion: @escaping (Result<ActivityModelArray, NetworkServiceError>) -> Void
    ) {
        networkService.request(
            urlString: endpoint.urlString,
            method: .post,
            parameters: request.toDictionary() ?? [:],
            headers: [:],
            body: nil,
            completion: completion
        )
    }
    
    private let networkService: NetworkServiceProtocol
}
