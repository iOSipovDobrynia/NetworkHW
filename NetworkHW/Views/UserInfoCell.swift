//
//  UserInfoCell.swift
//  NetworkHW
//
//  Created by Goodwasp on 09.09.2023.
//

import UIKit
import MapKit

class UserInfoCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var fullnameLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    
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
        
        guard let latitude = Double(user.location.coordinates.latitude),
        let longitude = Double(user.location.coordinates.longitude) else {
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        addAnnotationToMapView(at: coordinate)
        setMapViewRegion(centeredAt: coordinate)
    }

    private func addAnnotationToMapView(at coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }

    private func setMapViewRegion(centeredAt coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

}
