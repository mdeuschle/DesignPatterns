//
//  AlbumView.swift
//  DesignPatterns
//
//  Created by Matt Deuschle on 7/21/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class AlbumView: UIView {
    private var coverImageView: UIView!
    private var activityIndicatorView: UIActivityIndicatorView!

    init(frame: CGRect, coverUrl: String) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .black
        coverImageView = UIView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
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

    func highLiteAlbum(_ didHighLiteAlbum: Bool) {
        backgroundColor = didHighLiteAlbum ? .white : .black
    }
}








