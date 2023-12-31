//
//  UserInfoCell.swift
//  NetworkHW
//
//  Created by Goodwasp on 09.09.2023.
//

import UIKit
import MapKit
import Kingfisher

final class UserInfoCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var fullnameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    // MARK: - Override func
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage?.image = nil
    }
    
    // MARK: - Public func
    func configure(with user: User) {
        setupLabels(with: user)
        setupMapView(with: user.location.coordinates)
        
        guard let imageUrl = URL(string: user.picture.large) else { return }
        userImage.kf.setImage(with: imageUrl)
    }
    
    // MARK: - Private func
    private func setupLabels(with user: User) {
        fullnameLabel.text = user.name.fullname
        dateLabel.text = user.dob.describe
        locationLabel.text = """
        Location: \(user.location.describe)
        Coordinates: \(user.location.coordinates.describe)
        """
    }
    
    private func setupMapView(with coordinates: Coordinates) {
        guard let latitude = Double(coordinates.latitude),
              let longitude = Double(coordinates.longitude) else {
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
