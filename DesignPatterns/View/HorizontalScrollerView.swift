//
//  HorizontalScrollerView.swift
//  DesignPatterns
//
//  Created by Matt Deuschle on 7/22/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

protocol HorizontalScrollerViewDataSource: class {
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int
    func horizontalScrollerViewAt(_ horizontalScrollerView: HorizontalScrollerView,
                                  atIndex: Int) -> UIView
}

protocol HorizontalScrollerViewDelegate: class {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView,
                                didSelectViewAt index: Int)
}

class HorizontalScrollerView: UIView {
    weak var dataSource: HorizontalScrollerViewDataSource?
    weak var delegate: HorizontalScrollerViewDelegate?

    private enum ViewConstants {
        static let padding: CGFloat = 10
        static let dimensions: CGFloat = 100
        static let offSet: CGFloat = 100
    }

    private let scrollView = UIScrollView()
    private var contentViews = [UIView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initScrollView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initScrollView()
    }

    func initScrollView() {
        scrollView.delegate = self
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(scrollerTapped(_:)))
        scrollView.addGestureRecognizer(tapGestureRecognizer)
    }

    func scrollToView(at index: Int, animated: Bool = true) {
        let centralView = contentViews[index]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scrollView.bounds.width / 2)
        let cgPoint = CGPoint(x: targetOffsetX, y: 0)
        scrollView.setContentOffset(cgPoint, animated: animated)
    }

    @objc private func scrollerTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: scrollView)
        guard let index = contentViews.index(where: { $0.frame.contains(location) }) else {
            return
        }
        delegate?.horizontalScrollerView(self, didSelectViewAt: index)
        scrollToView(at: index)
    }

    func view(at index: Int) -> UIView {
        return contentViews[index]
    }

    func reload() {
        guard let dataSource = dataSource else { return }
        contentViews.forEach { $0.removeFromSuperview() }
        var xValue = ViewConstants.offSet
        contentViews = (0..<dataSource.numberOfViews(in: self)).map { index in
            xValue += ViewConstants.padding
            let view = dataSource.horizontalScrollerViewAt(self, atIndex: index)
            view.frame = CGRect(x: CGFloat(xValue),
                                y: ViewConstants.padding,
                                width: ViewConstants.dimensions,
                                height: ViewConstants.dimensions)
            scrollView.addSubview(view)
            xValue += ViewConstants.dimensions + ViewConstants.padding
            return view
        }
    }

    private func centerCurrentView() {
        let centerRect = CGRect(
            origin: CGPoint(x: scrollView.bounds.midX - ViewConstants.padding, y: 0),
            size: CGSize(width: ViewConstants.padding, height: bounds.height)
        )

        guard let selectedIndex = contentViews.index(where: { $0.frame.intersects(centerRect) })
            else { return }
        let centralView = contentViews[selectedIndex]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scrollView.bounds.width / 2)

        scrollView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        delegate?.horizontalScrollerView(self, didSelectViewAt: selectedIndex)
    }
}

extension HorizontalScrollerView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentView()
    }
}















