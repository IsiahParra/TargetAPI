//
//  NetworkingController.swift
//  TargetAPI
//
//  Created by Isiah Parra on 10/6/22.
//

import Foundation
import UIKit

class NetworkController {
    private static let baseURLString = "https://api.redcircleapi.com/request"
    
    static func fetchTopLevelDictionary(with url: URL, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void) {
        guard let baseURL = URL(string: baseURLString) else {return}
        print(baseURL)
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                print("There has been an error fetching the data. The url is \(baseURL)", error.localizedDescription)
                completion(.failure(.badURL))
            }
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let searchList = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(searchList))
            } catch {
                print("Error", error.localizedDescription)
                completion(.failure(.errorDecoding(error)))
            }
        }.resume()
    }
    static func fetchSearchItem(with urlString: String, completion: @escaping (Result<SearchResultDictionary, NetworkError>) -> Void) {
        // comeback and see if i need to change the let to var
        guard var searchURL = URL(string: baseURLString) else {
            completion(.failure(.badURL))
            return
        }
        searchURL.appendPathComponent(urlString)
        URLSession.shared.dataTask(with: searchURL) { data, _, error in
            if let error = error {
                print("Error has happened", error.localizedDescription)
                completion(.failure(.couldNotUnwrap))
                return
            }
            guard let searchData = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let searchedItem = try JSONDecoder().decode(SearchResultDictionary.self, from: searchData)
                completion(.success(searchedItem))
            } catch {
                print("Error has happend.", error.localizedDescription)
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
                print("Error has happened for image", error.localizedDescription)
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
