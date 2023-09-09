//
//  UsersInfoViewController.swift
//  NetworkHW
//
//  Created by Goodwasp on 09.09.2023.
//

import UIKit


final class UsersInfoViewController: UICollectionViewController {
    var users: [User] = []
    
    // MARK: - View's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellWithReuseIdentifier: "UserInfoCell")
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserInfoCell", for: indexPath)
        guard let cell = cell as? UserInfoCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: users[indexPath.item])
        return cell
    }

    // MARK: UICollectionViewDelegate
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UsersInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height)
    }
}
