//
//  Comment.swift
//  MVVMDemo
//
//  Created by саргашкаева on 19.03.2023.
//

import Foundation


struct Comment: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case userId, id, title, body
    }
    
    init(decoder: Decoder) throws {
        let coder = try decoder.container(keyedBy: CodingKeys.self)
        id = try coder.decodeIfPresent(Int.self, forKey: .id)!
        userId = try coder.decodeIfPresent(Int.self, forKey: .userId)!
        title = try coder.decodeIfPresent(String.self, forKey: .title)!
        body = try coder.decodeIfPresent(String.self, forKey: .body)!
    }
}
