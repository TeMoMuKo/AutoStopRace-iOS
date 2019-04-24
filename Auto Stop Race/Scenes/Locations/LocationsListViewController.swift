//
//  LocationsListViewController.swift
//  Auto Stop Race
//
//  Created by RI on 16/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SKPhotoBrowser

class LocationsListViewController: UIViewControllerWithMenu {

    private lazy var scrollableStackView: ScrollableStackView = { scrollableStackView in
        scrollableStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollableStackView.backgroundColor = .white
        return scrollableStackView
    }(ScrollableStackView())

    var viewModel: LocationsViewModel!

    private let bag = DisposeBag()

    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle()
        setupScrollableStackView()
        setupConstraints()
    }

    private func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_teams", comment: "")
    }

    private func setupScrollableStackView() {
        view.addSubview(scrollableStackView)

        viewModel.locationRecords.asDriver().drive(onNext: { [weak self] locations in
            guard let self = self else { return }
            self.scrollableStackView.clearTiles()
            locations.forEach { location in
                let tile = UserLocationTile()
                tile.imageTapAction = self.showImagePreview
                tile.location = location
                tile.inset = TileInsets(top: 16, left: 16, bottom: 16, right: 16)
                self.scrollableStackView.addTile(tile: tile)
            }
        }).disposed(by: bag)
    }

    func showImagePreview(imageUrl: String, caption: String?) {
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL(imageUrl)
        if let caption = caption {
            photo.caption = caption
        }

        photo.shouldCachePhotoURLImage = true
        images.append(photo)

        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        self.navigationController?.present(browser, animated: true, completion: {})
    }

    private func setupConstraints() {
        scrollableStackView.strechOnSafeArea()
    }
}
