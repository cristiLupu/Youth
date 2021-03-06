//
//  SearchPhotosViewController.swift
//  Youth
//
//  Created by Cristian Lupu on 01/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import SwiftMessages
import UIKit

final class SearchPhotosViewController: UIViewController {

    deinit {
        // Remove text field observer
        titleView?.textField.removeTarget(nil,
                                          action: nil,
                                          for: .editingChanged)
    }

    // MARK: Output

    var output: SearchPhotosViewOutput?

    // MARK: Title View

    private weak var titleView: YouthNavigationSearchTitleView?

    // MARK: Layout Bar Button Item

    private weak var layoutBarButtonItem: UIBarButtonItem?

    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.viewDidAppear()
    }

    // MARK: Actions

    @objc
    private func didTapLayoutButton(_ sender: UIBarButtonItem) {
        output?.didTapLayoutButton()
    }

    @objc
    private func didChangeSearchText(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }

        output?.didChange(searchText: text)
    }
}

// MARK: SearchPhotosViewInput

extension SearchPhotosViewController: SearchPhotosViewInput {
    func setUpInitialState(collectionLayout: YouthCollectionLayout) {
        view.backgroundColor = .white

        let titleView = YouthNavigationSearchTitleView()
        titleView.set(placeholder: "Search Photos")

        // Add text field observer
        titleView.textField.addTarget(self,
                                      action: #selector(didChangeSearchText(_:)),
                                      for: .editingChanged)

        navigationItem.titleView = titleView

        self.titleView = titleView

        let layoutBarButton: UIBarButtonItem

        switch collectionLayout {
        case .grid:
            layoutBarButton = UIBarButtonItem(image: UIImage(named: "Actions/Layout/layout-grid"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapLayoutButton(_:)))
        case .list:
            layoutBarButton = UIBarButtonItem(image: UIImage(named: "Actions/Layout/layout-list"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapLayoutButton(_:)))
        }

        navigationItem.rightBarButtonItem = layoutBarButton

        layoutBarButtonItem = layoutBarButton
    }

    func updateState(for collectionLayout: YouthCollectionLayout) {
        switch collectionLayout {
        case .grid:
            layoutBarButtonItem?.image = UIImage(named: "Actions/Layout/layout-grid")
        case .list:
            layoutBarButtonItem?.image = UIImage(named: "Actions/Layout/layout-list")
        }
    }

    func showKeyboard() {
        titleView?.textFieldBecomeFirstResponder()
    }

    func photosCollectionCanvasView() -> UIView {
        return view
    }

    func showNotification(withText text: String) {
        let notificationView = NotificationView()
        notificationView.set(title: text)

        var config = SwiftMessages.Config()
        config.ignoreDuplicates = true
        config.presentationContext = .view(view)
        config.presentationStyle = .top

        SwiftMessages.show(config: config, view: notificationView)
    }
}
