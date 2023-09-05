//
//  User.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

struct Result: Decodable {
    let results: [User]?
}

struct User: Decodable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
}

struct Name: Decodable {
    let title: String?
    let first: String?
    let last: String?
}
struct Location: Decodable {
    let city: String?
    let state: String?
    let country: String?
    let postcode: Int?
}
