//
//  NetworkManager.swift
//  NetworkHW
//
//  Created by Goodwasp on 08.09.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
}

enum Link: String {
    case users = "https://randomuser.me/api/?results=15"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchUsers(from url: String?, completion: @escaping(Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "There is no localized description")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response.results ?? []))
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
