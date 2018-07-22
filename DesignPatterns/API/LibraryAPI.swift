//
//  Service.swift
//  DesignPatterns
//
//  Created by Matt Deuschle on 7/21/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

final class LibraryAPI {
    let shared = LibraryAPI()
    private init() {}
    private let persistencyManager = PersistencyManager()
    private let httpClient = HTTPClient()
    private let isOnline = false

    func getAlbums() -> [Album] {
        return persistencyManager.getAlbums()
    }

    func add(album: Album, at index: Int) {
        persistencyManager.add(album: album, at: index)
        if isOnline {
            httpClient.postRequest("/api/addAlbum", body: album.description)
        }
    }

    func remove(album: Album, at index: Int) {
        persistencyManager.remove(album: album, at: index)
        if isOnline {
            httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
}
