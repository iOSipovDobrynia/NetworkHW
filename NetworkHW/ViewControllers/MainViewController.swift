//
//  ViewController.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

import UIKit

enum Actions: String, CaseIterable {
    case fetchUser = "Fetch User"
    case fetchUsers = "Fetch Users"
    case fetchFemale = "Fetch Female"
    case fetchMale = "Fetch Male"
}

class MainViewController: UICollectionViewController {

    private let actions = Actions.allCases
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "action", for: indexPath)
        guard let actionCell = cell as? ActionCell else { return UICollectionViewCell() }
        actionCell.actionLabel.text = actions[indexPath.item].rawValue
        
        return cell
    }
    
}

