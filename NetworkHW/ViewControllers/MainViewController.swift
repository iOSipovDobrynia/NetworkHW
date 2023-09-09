//
//  ViewController.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    var users: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
   
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "action", for: indexPath)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    // MARK: - Private func
    private func fetchUsers() {
        NetworkManager.shared.fetchUsers(from: Link.users.rawValue) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                print(error)
            }
        }
    }
}


