//
//  AppServices.swift
//  Session09
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import Alamofire

class AppServices {
    static let shared = AppServices()
    
    // baseUrl
    private let baseUrl = "https://2782e730-dbaf-414a-8426-bc759689516f.mock.pstmn.io"
    
    // endPoints
    private var getPriorities: String { "\(baseUrl)/getPriorities" }
    private var getTags: String { "\(baseUrl)/getTags"}
    private var getCategories: String { "\(baseUrl)/getAllCategories"}
    
    func getListPriorities() async throws -> [Priority] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(getPriorities)
                .validate() // validando response
                .responseDecodable(of: [Priority].self) { resp in //deserializar items
                    switch resp.result {
                    case .success(let items): continuation.resume(returning: items)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getListTags() async throws -> [Tag] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(getTags)
                .validate() // validando response
                .responseDecodable(of: [Tag].self) { resp in //deserializar items
                    switch resp.result {
                    case .success(let items): continuation.resume(returning: items)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getListCategories() async throws -> [Category] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(getCategories)
                .validate() // validando response
                .responseDecodable(of: [Category].self) { resp in //deserializar items
                    switch resp.result {
                    case .success(let items): continuation.resume(returning: items)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
        }
    }
}
