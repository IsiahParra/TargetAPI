//
//  Search.swift
//  TargetAPI
//
//  Created by Isiah Parra on 10/6/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case requestInfo = "request_info"
        case searchResults = "search_results"
        
    }
    let requestInfo: RequestInfo
    let searchResults: [SearchResult]
    
    
}
struct RequestInfo: Decodable {
    let success: Bool
}

struct RequestParameters: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
        case searchTerm = "search_term"
        case sortBy = "sort_by"
    }
    let type: String
    let searchTerm: String
    let sortBy: String
}

struct RequestMetaData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
    }
    let createdAt: String
}

struct SearchResult: Decodable {
    let product: Product
}

struct Product: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title
        case brand
        case rating
        case image = "main_image"
    }
    let title: String?
    let brand: String?
    let rating: Double?
    let image: String?
    
}
