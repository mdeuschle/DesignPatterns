//
//  PersistencyManager.swift
//  DesignPatterns
//
//  Created by Matt Deuschle on 7/21/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation
import UIKit

final class PersistencyManager {

    private var albums = [Album]()

    private var cache: URL {
        return FileManager.default.urls(for: .cachesDirectory,
                                        in: .userDomainMask)[0]
    }

    private var documents: URL {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask)[0]
    }

    private enum Filenames {
        static let albums = "albums.json"
    }

    init() {
        let savedURL = documents.appendingPathComponent(Filenames.albums)
        var data = try? Data(contentsOf: savedURL)
        if data == nil, let bundleURL = Bundle.main.url(forResource: Filenames.albums, withExtension: nil) {
            data = try? Data(contentsOf: bundleURL)
        }

        if let albumData = data,
            let decodedAlbums = try? JSONDecoder().decode([Album].self, from: albumData) {
            albums = decodedAlbums
            saveAlbums()
        }
    }

    func saveAlbums() {
        let url = documents.appendingPathComponent(Filenames.albums)
        let endcoder = JSONEncoder()
        guard let encodedData = try? endcoder.encode(url) else { return }
        try? encodedData.write(to: url)
    }

    func getAlbums() -> [Album] {
        return albums
    }

    func add(album: Album, at index: Int) {
        if albums.count >= index {
            albums.insert(album, at: index)
        } else {
            albums.append(album)
        }
    }

    func remove(album: Album, at index: Int) {
        albums.remove(at: index)
    }

    func saveImage(_ image: UIImage, fileName: String) {
        let url = cache.appendingPathComponent(fileName)
        guard let data = UIImagePNGRepresentation(image) else { return }
        try? data.write(to: url)
    }

    func getImage(with fileName: String) -> UIImage? {
        let url = cache.appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
}





