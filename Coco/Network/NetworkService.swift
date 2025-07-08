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
                completeOnMain(.failure(.bodyParsingFailed), completion)
                return nil
            }
        }

        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            NetworkLogger.logResponse(data: data, response: response, error: error)
            
            if let error: Error = error {
                let nsError: NSError = error as NSError
                if nsError.code == NSURLErrorNotConnectedToInternet {
                    completeOnMain(.failure(.noInternetConnection), completion)
                    return
                }
                assertionFailure("Request Failed")
                completeOnMain(.failure(.requestFailed(error)), completion)
                return
            }

            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                assertionFailure("invalid Response")
                completeOnMain(.failure(.invalidResponse), completion)
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                completeOnMain(.failure(.statusCode(httpResponse.statusCode)), completion)
                return
            }

            // Decode response
            guard let data: Data = data else {
                completeOnMain(.failure(.invalidResponse), completion)
                return
            }

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

                if let arrayType: any JSONArrayProtocol.Type = T.self as? JSONArrayProtocol.Type,
                   let jsonArray: [JSONObject] = jsonObject as? [JSONObject] {
                    if let typedArray: T = try? arrayType.init(jsonArray: jsonArray) as? T {
                        completeOnMain(.success(typedArray), completion)
                        return
                    } else {
                        completeOnMain(.failure(.decodingFailed(NSError(domain: "Failed to cast JSONArray", code: -1))), completion)
                        return
                    }
                }

                if let jsonDict: JSONObject = jsonObject as? JSONObject {
                    let decoded = try T(json: jsonDict)
                    completeOnMain(.success(decoded), completion)
                    return
                }
            } catch {
                assertionFailure("Decoding has Failed with Error: \(error)")
                completeOnMain(.failure(.decodingFailed(error)), completion)
            }
        }
        
        task.resume()
        return task
    }
}

private extension NetworkService {
    func completeOnMain<T>(_ result: Result<T, NetworkServiceError>, _ completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
