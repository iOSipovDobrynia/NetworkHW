//
//  UserInfoCell.swift
//  NetworkHW
//
//  Created by Goodwasp on 09.09.2023.
//

import UIKit

class UserInfoCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var fullnameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Override func
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - func
    func configure(with user: User) {
        fullnameLabel.text = user.name.fullname
        
        NetworkManager.shared.fetchImage(from: user.picture.large) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.userImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

}