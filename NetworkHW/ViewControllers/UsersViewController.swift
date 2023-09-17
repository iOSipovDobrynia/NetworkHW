//
//  MainViewController.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

import UIKit
import Kingfisher

final class UsersViewController: UICollectionViewController {
    
    // MARK: - Public properties
    private var users: [User] = []
    
    // MARK: - Views's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        collectionView.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: "UserCell")
        setupRefreshControl()
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath)
        guard let cell = cell as? UserCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: users[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showInfo", sender: indexPath)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo" {
            guard let userInfoVC = segue.destination as? UsersInfoViewController else {
                return
            }
            userInfoVC.users = users
            userInfoVC.previousIndexPath = sender as? IndexPath
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem) {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
    }
    
    // MARK: - Private func
    @objc
    private func fetchUsers() {
        NetworkManager.shared.fetchUsers(from: Link.users.rawValue) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.collectionView.reloadData()
                if self?.collectionView.refreshControl != nil {
                    self?.collectionView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchUsers), for: .valueChanged)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 140)
    }
}


