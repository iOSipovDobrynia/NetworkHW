//
//  UserCell.swift
//  NetworkHW
//
//  Created by Goodwasp on 09.09.2023.
//

import UIKit
import Kingfisher

final class UserCell: UICollectionViewCell {
   
    // MARK: - IBOutlets
    @IBOutlet var userImage: UIImageView!    
    @IBOutlet var fullnameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    // MARK: - Public func
    func configure(with user: User) {
        fullnameLabel.text = user.name.fullname
        ageLabel.text = "\(user.dob.age) y.o."
        locationLabel.text = user.location.describe
        
        guard let imageUrl = URL(string: user.picture.large) else { return }
        let processor = DownsamplingImageProcessor(size: userImage.bounds.size)
        userImage.kf.indicatorType = .activity
        userImage.kf.setImage(
            with: imageUrl,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage,
                .transition(.fade(0.5))
            ]
        )
    }
}
