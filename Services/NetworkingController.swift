//
//  NetworkingController.swift
//  TargetAPI
//
//  Created by Isiah Parra on 10/6/22.
//

import Foundation
import UIKit

class NetworkController {
    //MARK: Private keys
    private static let baseURLString = "https://api.redcircleapi.com/request"
    private static let kApiKey = "api_key"
    private static let valueKey = "4FDC0BE743EB4E18B1ABF5E9FCF9E6DA"
    private static let kType = "type"
    private static let typeValue = "search"
    private static let kSearchTerm = "search_term"
    private static let ksortBy = "sort_by"
    private static let ratingValue = "highest_rating"

    static func fetchItems(with searchTerm: String, completion: @escaping (Result<[SearchResult], NetworkError>) -> Void) {
        guard let baseURL = URL(string: baseURLString) else {return}
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiKeyQuery = URLQueryItem(name: kApiKey, value: valueKey)
        let typeQuery = URLQueryItem(name: kType, value: typeValue)
        let searchQuery = URLQueryItem(name: kSearchTerm, value: searchTerm)
        let sortQuery = URLQueryItem(name: ksortBy, value: ratingValue)
        urlComponents?.queryItems = [apiKeyQuery,typeQuery,searchQuery,sortQuery]
        
        guard let finalURL = urlComponents?.url else {return}
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Could not unwrap this url, error.", error.localizedDescription)
                completion(.failure(.couldNotUnwrap))
                return
            }
            guard let searchData = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let searchResults = try JSONDecoder().decode(TopLevelDictionary.self, from: searchData).searchResults

                completion(.success(searchResults))
            } catch {
                print("There was an error decoding the data.", error.localizedDescription)
                completion(.failure(.errorDecoding(error)))
            }
        }.resume()
    }
    
    static func fetchImage(with imageString: String, completion: @escaping(Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: imageString) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("Error has happened for fetching the  image", error.localizedDescription)
                completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(.errorDecoding(error!)))
                return
            }
            completion(.success(image))
        }.resume()
    }
    
}// End of class
