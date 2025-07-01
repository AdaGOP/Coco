//
//  NetworkService.swift
//  Coco
//
//  Created by Jackie Leonardy on 30/06/25.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    @discardableResult
    func request<T: JSONDecodable>(
        urlString: String,
        method: HTTPMethod,
        parameters: JSONObject,
        headers: [String: String],
        body: JSONEncodable?,
        completion: @escaping (Result<T, NetworkServiceError>) -> Void
    ) -> URLSessionDataTask?
}

final class NetworkService: NetworkServiceProtocol {
    static let shared: NetworkService = NetworkService()
    
    private init() { }
    
    @discardableResult
    func request<T: JSONDecodable>(
        urlString: String,
        method: HTTPMethod = .get,
        parameters: JSONObject = [:],
        headers: [String: String] = [:],
        body: JSONEncodable? = nil,
        completion: @escaping (Result<T, NetworkServiceError>) -> Void
    ) -> URLSessionDataTask? {
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let apiKey: String = Secrets.shared.apiKey {
            request.setValue(apiKey, forHTTPHeaderField: "apikey")
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        
        if let body: JSONObject = body?.toDictionary() {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                completion(.failure(.bodyParsingFailed))
                return nil
            }
        }

        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error: Error = error {
                let nsError: NSError = error as NSError
                if nsError.code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noInternetConnection))
                    return
                }
                assertionFailure("Request Failed")
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                assertionFailure("invalid Response")
                completion(.failure(.invalidResponse))
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.statusCode(httpResponse.statusCode)))
                return
            }

            // Decode response
            guard let data: Data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

                if let arrayType: any JSONArrayProtocol.Type = T.self as? JSONArrayProtocol.Type,
                   let jsonArray: [JSONObject] = jsonObject as? [JSONObject] {
                    if let typedArray: T = try? arrayType.init(jsonArray: jsonArray) as? T {
                        completion(.success(typedArray))
                        return
                    } else {
                        completion(.failure(.decodingFailed(NSError(domain: "Failed to cast JSONArray", code: -1))))
                        return
                    }
                }

                if let jsonDict: JSONObject = jsonObject as? JSONObject {
                    let decoded = try T(json: jsonDict)
                    completion(.success(decoded))
                    return
                }
            } catch {
                assertionFailure("Decoding has Failed with Error: \(error)")
                completion(.failure(.decodingFailed(error)))
            }
        }
        
        task.resume()
        return task
    }
}
