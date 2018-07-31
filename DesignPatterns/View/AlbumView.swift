//
//  AlbumView.swift
//  DesignPatterns
//
//  Created by Matt Deuschle on 7/21/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class AlbumView: UIView {
    private var coverImageView: UIImageView!
    private var activityIndicatorView: UIActivityIndicatorView!
    private var valueObservation: NSKeyValueObservation!
    static let imageView = "imageView"
    static let coverUrl = "coverUrl"

    init(frame: CGRect, coverUrl: String) {
        super.init(frame: frame)
        commonInit()
        NotificationCenter.default.post(name: .BLDownloadImage,
                                        object: self,
                                        userInfo: [AlbumView.imageView: coverImageView,
                                                   AlbumView.coverUrl: coverUrl])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .black
        coverImageView = UIImageView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        valueObservation = coverImageView.observe(\.image,
                                                  options: [.new]) { [unowned self] observed, change in
            if change.newValue is UIImage {
                self.activityIndicatorView.stopAnimating()
            }
        }
        addSubview(coverImageView)

        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)

        // contraints
        let contraints: [NSLayoutConstraint] = [
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]

        NSLayoutConstraint.activate(contraints)
    }

    func highlightAlbum(_ didHightlightAlbum: Bool) {
        backgroundColor = didHightlightAlbum ? .white : .black
    }
}








