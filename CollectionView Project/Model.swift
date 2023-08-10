//
//  File.swift
//  Sample2
//
//  Created by Ajay Sarkate on 26/07/23.
//

import Foundation

struct Result: Decodable {
    let id: String
    let tags: [Tag]
}

struct Tag: Decodable, Hashable {
    let title: String
    let source: Source?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    static func == (lhs: Tag, rhs: Tag) -> Bool {
        lhs.title == rhs.title
    }
}

struct Source: Decodable {
    let title: String
    let description: String
    let cover_photo: CoverPhoto
}

struct CoverPhoto: Decodable {
    let id: String
    let urls: ImageURL
    let width: CGFloat
    let height: CGFloat
}

struct ImageURL: Decodable {
    let regular: String
}


