//
//  YouthUserView.swift
//  Youth
//
//  Created by Cristian Lupu on 6/10/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import SnapKit
import UIKit

/// Describe an object who receive actions from YouthUserView
protocol YouthUserViewDelegate: class {
    /**
     Tell that user view did tapped
     
     - parameter userView: View that did tapped
     */
    func didTapUserView(_ userView: YouthUserView)
}

/// Youth User View. Used for showing general information about user.
final class YouthUserView: UIView {
    // MARK: Deinitialization

    deinit {
        // Remove gesture regcognizers
        tapGesture.removeTarget(nil, action: nil)
        removeGestureRecognizer(tapGesture)
    }

    // MARK: Private properties

    private weak var userAvatarImageView: UIImageView!
    private weak var userNamesStackView: UIStackView!
    private weak var userFullNameLabel: UILabel!
    private weak var usernameLabel: UILabel!
    private weak var tapGesture: UITapGestureRecognizer!

    private var configuredUserAvatarImageView: UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.masksToBounds = true
        return imageView
    }

    private var configuredUserNamesStackView: UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }

    private var configuredUserFullNameLabel: UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = YouthFonts.avenirNextBold(size: 10).font
        label.textAlignment = .left
        return label
    }

    private var configuredUsernameLabel: UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = YouthFonts.avenirNextRegular(size: 10).font
        label.textAlignment = .left
        return label
    }

    // MARK: Public properties

    /// Delegate
    weak var delegate: YouthUserViewDelegate?

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    // MARK: View life-cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        // Round userAvatarImageView
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height / 2.0
    }

    // MARK: Private methods

    private func commonInit() {
        backgroundColor = .clear

        let userImageView = configuredUserAvatarImageView

        addSubview(userImageView)

        userImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalTo(userImageView.snp.height)
        }

        let namesStackView = configuredUserNamesStackView

        addSubview(namesStackView)

        namesStackView.snp.makeConstraints { maker in
            maker.leading.equalTo(userImageView.snp.trailing).offset(8)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
        }

        let fullNameLabel = configuredUserFullNameLabel

        namesStackView.addArrangedSubview(fullNameLabel)

        let usernameLabel = configuredUsernameLabel

        namesStackView.addArrangedSubview(usernameLabel)

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapSelf(_:)))

        addGestureRecognizer(tapGesture)

        self.userAvatarImageView = userImageView
        self.userNamesStackView = namesStackView
        self.userFullNameLabel = fullNameLabel
        self.usernameLabel = usernameLabel
        self.tapGesture = tapGesture
    }

    // MARK: Actions

    @objc
    private func didTapSelf(_ gestureRecognizer: UITapGestureRecognizer) {
        delegate?.didTapUserView(self)
    }

    // MARK: Public methods

    /**
     Set user avatar image url
     
     - parameter userAvatarImageURL: Image URL
     */
    func set(userAvatarImageURL: URL) {
        userAvatarImageView.loadImage(with: userAvatarImageURL)
    }

    /**
     Set user fullname
     
     - parameter userFullName: User fullname
     */
    func set(userFullName: String) {
        userFullNameLabel.text = userFullName
    }

    /**
     Set username
     
     - parameter username: Username
     */
    func set(username: String) {
        usernameLabel.text = username
    }
}

// MARK: ViewModelReceiver

extension YouthUserView: ViewModelReceiver {
    typealias ViewModelType = YouthUserViewModel

    convenience init(viewModel: YouthUserViewModel) {
        self.init()

        updateSelf(viewModel: viewModel)
    }

    func updateInConformance(with viewModel: YouthUserViewModel) {
        updateSelf(viewModel: viewModel)
    }

    private func updateSelf(viewModel: YouthUserViewModel) {
        if let url = viewModel.userAvatarImageURL {
            set(userAvatarImageURL: url)
        }
        set(userFullName: viewModel.userFullname)
        set(username: viewModel.username)
    }
}
