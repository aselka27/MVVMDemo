//
//  Contact.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//

import Foundation



struct Contact: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, email, address, phone, website, company
    }
    init(decoder: Decoder) throws {
        let coder = try decoder.container(keyedBy: CodingKeys.self)
        id = try coder.decodeIfPresent(Int.self, forKey: .id)!
        name = try coder.decodeIfPresent(String.self, forKey: .name)!
        username = try coder.decodeIfPresent(String.self, forKey: .username)!
        email = try coder.decodeIfPresent(String.self, forKey: .email)!
        address = try coder.decodeIfPresent(Address.self, forKey: .address)!
        phone = try coder.decodeIfPresent(String.self, forKey: .phone)!
        website = try coder.decodeIfPresent(String.self, forKey: .website)!
        company = try coder.decodeIfPresent(Company.self, forKey: .company)!
    }
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    enum CodingKeys: String, CodingKey {
        case street, suite, city, zipcode, geo
    }
    init(decoder: Decoder) throws {
        let coder = try decoder.container(keyedBy: CodingKeys.self)
        street = try coder.decodeIfPresent(String.self, forKey: .street)!
        suite = try coder.decodeIfPresent(String.self, forKey: .suite)!
        city = try coder.decodeIfPresent(String.self, forKey: .city)!
        zipcode = try coder.decodeIfPresent(String.self, forKey: .zipcode)!
        geo = try coder.decodeIfPresent(Geo.self, forKey: .geo)!
    }
}
struct Geo: Codable {
    let lat: String
    let lng: String
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
    init(decoder: Decoder) throws {
        let coder = try decoder.container(keyedBy: CodingKeys.self)
        lat = try coder.decodeIfPresent(String.self, forKey: .lat)!
        lng = try coder.decodeIfPresent(String.self, forKey: .lng)!
    }
}
struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    enum CodingKeys: String, CodingKey {
        case name, catchPhrase, bs
    }
    init(decoder: Decoder) throws {
        let coder = try decoder.container(keyedBy: CodingKeys.self)
        name = try coder.decodeIfPresent(String.self, forKey: .name)!
        catchPhrase = try coder.decodeIfPresent(String.self, forKey: .catchPhrase)!
        bs = try coder.decodeIfPresent(String.self, forKey: .bs)!
    }
}
