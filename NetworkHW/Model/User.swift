//
//  User.swift
//  NetworkHW
//
//  Created by Goodwasp on 05.09.2023.
//

//struct Response: Decodable {
//    let results: [User]?
//}

struct User: Decodable {
    let name: Name
    let location: Location
    let email: String?
    let dob: Dob
    let picture: Picture
    
    init(name: Name, location: Location, email: String?, dob: Dob, picture: Picture) {
        self.name = name
        self.location = location
        self.email = email
        self.dob = dob
        self.picture = picture
    }
    
    init(userData: [String: Any]) {
        if let name = userData["name"] as? [String: Any],
           let location = userData["location"] as? [String: Any],
           let dob = userData["dob"] as? [String: Any],
           let picture = userData["picture"] as? [String: Any] {
            
            self.name = Name(nameData: name)
            self.location = Location(locationData: location)
            email = userData["email"] as? String
            self.dob = Dob(dodData: dob)
            self.picture = Picture(pictureData: picture)
        } else {
            self.name = Name(title: "", first: "", last: "")
            self.location = Location(
                city: "",
                country: "",
                coordinates: Coordinates(
                    latitude: "",
                    longitude: ""
                ),
                postcode: PostcodeValue.int(1)
            )
            self.email = ""
            self.dob = Dob(date: "", age: 0)
            self.picture = Picture(large: "")
        }
    }
    
    static func getUsers(from value: Any) -> [User] {
        guard let value = value as? [String: Any] else { return [] }
        guard let results = value["results"] as? [[String: Any]] else { return []}
        return results.map { User(userData: $0)}
    }
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
    
    var fullname: String {
        title + " " + first + " " + last
    }
  
    init(title: String, first: String, last: String) {
        self.title = title
        self.first = first
        self.last = last
    }
    
    init(nameData: [String: Any]) {
        title = nameData["title"] as? String ?? ""
        first = nameData["first"] as? String ?? ""
        last = nameData["last"] as? String ?? ""
    }
}

struct Location: Decodable {
    let city: String
    let country: String
    let coordinates: Coordinates
    let postcode: PostcodeValue
    
    var describe: String {
        "\(city), \(country), \(postcode)"
    }
    
    init(city: String, country: String, coordinates: Coordinates, postcode: PostcodeValue) {
        self.city = city
        self.country = country
        self.coordinates = coordinates
        self.postcode = postcode
    }
    
    init(locationData: [String: Any]) {
        city = locationData["city"] as? String ?? ""
        country = locationData["country"] as? String ?? ""
        if let coordinatesData = locationData["coordinates"] as? [String: Any] {
            coordinates = Coordinates(coordinatesData: coordinatesData)
        } else {
            coordinates = Coordinates(latitude: "", longitude: "")
        }
        postcode = PostcodeValue.int(1)
    }
}

struct Coordinates: Decodable {
    let latitude: String
    let longitude: String
    
    var describe: String {
        "\(latitude); \(longitude)"
    }
    
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(coordinatesData: [String: Any]) {
        latitude = coordinatesData["latitude"] as? String ?? ""
        longitude = coordinatesData["longitude"] as? String ?? ""
    }
}

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

struct Dob: Decodable {
    let date: String
    let age: Int
    
    var describe: String {
        String(date.prefix(10)) + ", " + String(age) + "y.o."
    }
    
    init(date: String, age: Int) {
        self.date = date
        self.age = age
    }
    
    init(dodData: [String: Any]) {
        date = dodData["date"] as? String ?? ""
        age = dodData["age"] as? Int ?? 0
    }
}

struct Picture: Decodable {
    let large: String
    
    init(large: String) {
        self.large = large
    }
    
    init(pictureData: [String: Any]) {
        large = pictureData["large"] as? String ?? ""
    }
}

extension PostcodeValue: CustomStringConvertible {
    var description: String {
        switch self {
        case .string(let string):
            return string
        case .int(let int):
            return "\(int)"
        }
    }
}
