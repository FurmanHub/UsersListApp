//
//  UsersListWorker.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit
import PromiseKit

enum APIError: Error {
    case badRequest
    case invalidResponse
}

final class UsersListWorker {
    private let session = URLSession(configuration: .default)
    private let usersStorage = UsersStorage(coreData: CoreDataContainer())
    
    func saveUsers(users: [User]) throws {
        try usersStorage.saveUsers(users: users)
    }
    
    func executeRequest<T: APIRequest, U> (request: T) -> Promise<U> where T.ResponseType == U {
        return Promise { seal in
            guard let url = construct(from: request) else {
                return seal.reject(APIError.badRequest)
            }
            firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.done { urlResponse in
                let userRepsonse = try JSONDecoder().decode(U.self, from: urlResponse.data)
                return seal.fulfill(userRepsonse)
            }.catch { error in
                return seal.reject(APIError.invalidResponse)
            }
        }
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
