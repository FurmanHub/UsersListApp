//
//  UsersListWorker.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

final class UsersListWorker {
    enum APIError: Error {
        case badRequest
        case invalidResponse
        case malformedURL
    }
    
    private let session = URLSession(configuration: .default)
    private let usersStorage = UsersStorage(coreData: CoreDataContainer())
    
    func saveUsers(users: [User]) throws {
        try usersStorage.saveUsers(users: users)
    }
    
    // I think it's too complicated for this app with 1 request...
    // Should be like separated service
    func executeRequest<T: APIRequest, U> (request: T, completion: @escaping (Result<U>) -> Void) where T.ResponseType == U {
        guard let url = construct(from: request) else {
            completion(Result.failure(APIError.malformedURL))
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {(data, response, error) -> Void in
            if let fetchedData = data {
                do {
                    let response = try JSONDecoder().decode(U.self, from: fetchedData)
                    completion(Result.success(response))
                } catch {
                    completion(Result.failure(APIError.invalidResponse))
                }
            } else {
                completion(Result.failure(APIError.badRequest))
            }
        }
        task.resume()
    }
    
    private func construct<T: APIRequest> (from request: T) -> URL? {
        let absolutePath = request.baseURLPath + parameterersString(from: request)
        let normalizedPath = absolutePath.replacingOccurrences(of: " ", with: "-")
        return URL(string: normalizedPath)
    }
    
    private func parameterersString<T: APIRequest> (from request: T) -> String {
        guard !request.parameters.isEmpty else {
            return ""
        }
        return "?" + request.parameters.map { $0.lowercased() + "=" + $1.lowercased() }.joined(separator: "&")
    }
}
