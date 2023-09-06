//
//  ViewController.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

import UIKit

enum Link: String {
    case user = "https://randomuser.me/api/"
    case users = "https://randomuser.me/api/?results=5"
    case female = "https://randomuser.me/api/?gender=female"
    case male = "https://randomuser.me/api/?gender=male"
}

enum Action: String, CaseIterable {
    case fetchUser = "Fetch User"
    case fetchUsers = "Fetch Users"
    case fetchFemale = "Fetch Female"
    case fetchMale = "Fetch Male"
}

class MainViewController: UICollectionViewController {

    // MARK: - Private properties
    private let actions = Action.allCases
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "action", for: indexPath)
        guard let actionCell = cell as? ActionCell else { return UICollectionViewCell() }
        actionCell.actionLabel.text = actions[indexPath.item].rawValue
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.item]
        switch action {
        case .fetchUser:
            fetchUser()
        case .fetchUsers:
            fetchUsers()
        case .fetchFemale:
            fetchFemale()
        case .fetchMale:
            fetchMale()
        }
    }
    
    // MARK: - Private func
    private func fetchUser() {
        guard let url = URL(string: Link.user.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "There is no localized description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(Result.self, from: data)
                print(result)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func fetchUsers() {
        guard let url = URL(string: Link.users.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "There is no localized description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(Result.self, from: data)
                print(result)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func fetchFemale() {
        guard let url = URL(string: Link.female.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No localized description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(Result.self, from: data)
                print(result)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func fetchMale() {
        guard let url = URL(string: Link.male.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No localized description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(Result.self, from: data)
                print(result)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

