//
//  ViewController.swift
//  DesignPatterns
//
//  Created by Matt Deuschle on 7/21/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var undoBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var trashBarButtonItem: UIBarButtonItem!

    private var currentAlbumIndex = 0
    private var currentAlbumData: [AlbumData]?
    private var albums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
        albums = LibraryAPI.shared.getAlbums()
        tableView.dataSource = self
        showAlbum(at: currentAlbumIndex)
    }

    private func showAlbum(at index: Int) {
        if index < albums.count && index >= 0 {
            let album = albums[index]
            currentAlbumData = album.tableRepresentation
        } else {
            currentAlbumData = nil
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAlbumData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let albumData = currentAlbumData {
            let album = albumData[indexPath.row]
            cell.textLabel?.text = album.title
            cell.detailTextLabel?.text = album.value
        }
        return cell
    }
}









