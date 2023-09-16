//
//  NetworkManager.swift
//  NetworkHW
//
//  Created by Goodwasp on 08.09.2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidUrl
    case noData
}

enum Link: String {
    case users = "https://randomuser.me/api/?results=2"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchUsers(from url: String, completion: @escaping(Result<[User], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let users = User.getUsers(from: value)
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.invalidUrl))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
