//
//  Search.swift
//  TargetAPI
//
//  Created by Isiah Parra on 10/6/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let requestInfo: RequestInfo
    let requestParameters: RequestParameters
    let requestMetaData: RequestMetaData
    let searchResult: [SearchResultDictionary]
    
}
struct RequestInfo: Decodable {
    private enum CodingKeys: String, CodingKey {
        case success
    }
    let success: String
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

struct SearchResultDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case position
        case title
        case brand
        case features = "feature_bullets"
        case rating
        case image = "main_image"
        case price
    }
    
    let position: Int
    let title: String
    let brand: String
    let features: String
    let rating: Double
    let image: String
    let price: Double
}

