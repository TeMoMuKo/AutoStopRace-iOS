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

class LocationsListViewController: UIViewControllerWithMenu, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    var viewModel: LocationsViewModel!

    var shareUrlSufix: String?

    let locationsSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = Theme.Color.blueMenu
        return searchBar
    }()

    let teamsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    private let disposeBag = DisposeBag()

    convenience init(viewModel: LocationsViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationsSearchBar.delegate = self

        setupNavigationBarTitle()
        setupShareBarButton()
        setupSearchBar()
    }

    private func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_teams", comment: "")
    }

    private func setupShareBarButton() {
        let menuImage = UIImage(named: "ic_share_white")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleShareTap))
        navigationItem.rightBarButtonItems = [menuBarButtonItem]
    }

    @objc func handleShareTap() {
        let urlTeam = shareUrlSufix ?? ""
        if let mapUrl = NSURL(string: ApiConfig.shareMapUrl + urlTeam) {
            let objectsToShare = [mapUrl]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }

    private func setupSearchBar() {
        let textfield: UITextField = locationsSearchBar.value(forKey: "searchField") as! UITextField
        textfield.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("hint_enter_team_number", comment: ""),
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        view.addSubview(locationsSearchBar)
    }

}
