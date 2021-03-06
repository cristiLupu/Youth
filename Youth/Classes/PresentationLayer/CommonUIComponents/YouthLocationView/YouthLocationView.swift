//
//  YouthLocationView.swift
//  Youth
//
//  Created by Cristian Lupu on 6/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Youth Location View. Used for showing location
final class YouthLocationView: UIView {
    // MARK: Private properties

    private weak var locationImageView: UIImageView!
    private weak var locationLabel: UILabel!

    private var configuredLocationImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icons/location")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private var configuredLocationLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = YouthFonts.avenirNextMedium(size: 10).font
        return label
    }

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    // MARK: Public methods

    /**
     Set location
     
     - parameter location: Location
     */
    func set(location: String) {
        locationImageView.isHidden = location.isEmpty
        locationLabel.text = location
    }

    // MARK: Private methods

    private func commonInit() {
        backgroundColor = .clear

        let imageView = configuredLocationImageView

        addSubview(imageView)

        imageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalTo(20)
            maker.width.equalTo(20)
        }

        let label = configuredLocationLabel

        addSubview(label)

        label.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing).offset(8)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
        }

        self.locationImageView = imageView
        self.locationLabel = label
    }
}

// MARK: ViewModelReceiver

extension YouthLocationView: ViewModelReceiver {
    typealias ViewModelType = YouthLocationViewModel

    convenience init(viewModel: YouthLocationViewModel) {
        self.init()
        updateSelf(viewModel: viewModel)
    }

    func updateInConformance(with viewModel: YouthLocationViewModel) {
        updateSelf(viewModel: viewModel)
    }

    private func updateSelf(viewModel: YouthLocationViewModel) {
        set(location: viewModel.location)
    }
}
