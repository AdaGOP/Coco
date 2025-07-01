//
//  ActivityFetcher.swift
//  Coco
//
//  Created by Jackie Leonardy on 01/07/25.
//

import Foundation

protocol ActivityFetcherProtocol: AnyObject {
    func fetchActivity(
        endpoint: ActivityEndpoint,
        completion: @escaping (Result<UserModelArray, NetworkServiceError>) -> Void
    )
}

final class ActivityFetcher: ActivityFetcherProtocol {
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchActivity(
        endpoint: ActivityEndpoint,
        completion: @escaping (Result<UserModelArray, NetworkServiceError>) -> Void
    ) {
        networkService.request(
            urlString: endpoint.urlString,
            method: .get,
            parameters: [:],
            headers: [:],
            body: nil,
            completion: completion
        )
    }
    
    private let networkService: NetworkServiceProtocol
}

