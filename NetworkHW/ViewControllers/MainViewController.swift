//
//  ViewController.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

import UIKit

final class MainViewController: UICollectionViewController {
   
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
    }
}


