//
//  MainViewController.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

import UIKit
import Alamofire

final class UsersViewController: UICollectionViewController {
    
    // MARK: - Public properties
    var users: [User] = []
    
    // MARK: - Views's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        collectionView.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: "UserCell")
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
    
    // MARK: - Private func
    private func fetchUsers() {
        AF.request(Link.users.rawValue)
            .validate()
            .responseJSON(completionHandler: { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let value = value as? [String: Any] else { return }
                    guard let results = value["results"] as? [[String: Any]] else { return }
                    for result in results {
                        guard let name = result["name"] as? [String: Any] else { return }
                        guard let location = result["location"] as? [String: Any] else { return }
                        guard let coordinates = location["coordinates"] as? [String: Any] else { return}
                        guard let dob = result["dob"] as? [String: Any] else { return }
                        guard let picture = result["picture"] as? [String: Any] else { return }
                        let user = User(
                            name: Name(
                                title: name["title"] as? String ?? "",
                                first: name["first"] as? String ?? "",
                                last: name["last"] as? String ?? ""
                            ),
                            location: Location(
                                city: location["city"] as? String ?? "",
                                country: location["country"] as? String ?? "",
                                coordinates: Coordinates(
                                    latitude: coordinates["latitude"] as? String ?? "",
                                    longitude: coordinates["longitude"] as? String ?? ""
                                ),
                                postcode: PostcodeValue.int(1)
                            ),
                            email: result["email"] as? String,
                            dob: Dob(
                                date: dob["date"] as? String ?? "",
                                age: dob["age"] as? Int ?? 0
                            ),
                            picture: Picture(large: picture["large"] as? String ?? "")
                        )
                        self?.users.append(user)
                    }
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 140)
    }
}


