//
//  User.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

struct Response: Decodable {
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
    let postcode: PostcodeValue?
    
    
    enum PostcodeValue: Decodable {
        case string(String)
        case int(Int)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()

            if let stringValue = try? container.decode(String.self) {
                self = .string(stringValue)
            } else if let intValue = try? container.decode(Int.self) {
                self = .int(intValue)
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid postcode value"
                )
            }
        }
    }
}
