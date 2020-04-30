//
//  GIFTextHeader.swift
//  SwiftPullToRefresh
//
//  Created by Leo Zhou on 2017/12/21.
//  Copyright © 2017年 Wiredcraft. All rights reserved.
//

import UIKit

class GIFTextHeader: GIFHeader {

    private let loadingText: String
    private let pullingText: String
    private let releaseText: String

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        return label
    }()

    init(data: Data, loadingText: String, pullingText: String, releaseText: String,
         height: CGFloat, action: @escaping () -> Void) {
        self.loadingText = loadingText
        self.pullingText = pullingText
        self.releaseText = releaseText
        super.init(data: data, isBig: false, height: height, action: action)
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        imageView.center = center.move(x: -label.bounds.midX - 4)
        label.center = center.move(x: imageView.bounds.midX + 4)
    }

    override func didUpdateState(_ isRefreshing: Bool) {
        super.didUpdateState(isRefreshing)
        label.text = isRefreshing ? loadingText : pullingText
        label.sizeToFit()
    }

    override func didUpdateProgress(_ progress: CGFloat) {
        super.didUpdateProgress(progress)
        label.text = progress == 1 ? releaseText : pullingText
        label.sizeToFit()
    }

}
