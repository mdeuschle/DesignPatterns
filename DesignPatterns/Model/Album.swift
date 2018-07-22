//
//  Album.swift
//  DesignPatterns
//
//  Created by Matt Deuschle on 7/21/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct Album {
    let title: String
    let artist: String
    let genre: String
    let coverUrl: String
    let year: String
}

extension Album: CustomStringConvertible {
    var description: String {
        return "title: \(title)" +
        "artist: \(artist)" +
        "genre: \(genre)" +
        "coverUrl: \(coverUrl)" +
        "year: \(year)"
    }
}

typealias AlbumData = (title: String, value: String)

extension Album {
    var tableRepresentation: [AlbumData] {
        return [
            ("TITLE", title),
            ("ARTIST", artist),
            ("GENRE", genre),
            ("YEAR", year)
        ]
    }
}







