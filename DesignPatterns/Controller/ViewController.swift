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
    @IBOutlet private weak var horizontalScrollerView: HorizontalScrollerView!
    
    private var currentAlbumIndex = 0
    private var currentAlbumData: [AlbumData]?
    private var albums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
        albums = LibraryAPI.shared.getAlbums()
        tableView.dataSource = self
        horizontalScrollerView.dataSource = self
        horizontalScrollerView.delegate = self
        horizontalScrollerView.reload()
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

extension ViewController: HorizontalScrollerViewDelegate {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int) {
        guard let previousAlbumView = horizontalScrollerView.view(at: currentAlbumIndex) as? AlbumView else {
            return
        }
        previousAlbumView.highlightAlbum(false)
        currentAlbumIndex = index
        guard let albumView = horizontalScrollerView.view(at: currentAlbumIndex) as? AlbumView else {
            return
        }
        albumView.highlightAlbum(true)
        showAlbum(at: index)
    }
}

extension ViewController: HorizontalScrollerViewDataSource {
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int {
        return albums.count
    }

    func horizontalScrollerViewAt(_ horizontalScrollerView: HorizontalScrollerView, atIndex: Int) -> UIView {
        let album = albums[atIndex]
        let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), coverUrl: album.coverUrl)
        if currentAlbumIndex == atIndex {
            albumView.highlightAlbum(true)
        } else {
            albumView.highlightAlbum(false)
        }
        return albumView
    }
}









