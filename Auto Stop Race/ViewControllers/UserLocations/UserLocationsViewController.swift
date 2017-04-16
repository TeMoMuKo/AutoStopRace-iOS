//
//  UserLocationsViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SnapKit

protocol UserLocationsViewControllerDelegate: class {
    func showMapTapped()
    func postNewLocationTapped()
}

class UserLocationsViewController: UIViewControllerWithMenu, UICollectionViewDelegateFlowLayout {

    let cellHeight: CGFloat = 100
    let bigCellHeight: CGFloat = 120
    
    var viewModel: UserLocationsViewModel!
    
    let disposeBag = DisposeBag()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    var refreshControl: UIRefreshControl!

    var backgroundImageLogo: UIView!
    
    convenience init(viewModel: UserLocationsViewModel) {
        self.init()
        
        self.viewModel = viewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.downloadLocations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundImage()
        setupNavigationBarTitle()
        setupPostNewLocationBarButton()
        setupCollectionView()
        setupRefreshControl()

        collectionView.register(UserLocationCell.self, forCellWithReuseIdentifier: UserLocationCell.Identifier)
        
        viewModel.locationRecords.asObservable()
            .bindTo(collectionView.rx.items(cellIdentifier: UserLocationCell.Identifier, cellType:UserLocationCell.self)) { row, location, cell in
                cell.locationRecord = location
            }
            .addDisposableTo(disposeBag)
 
        collectionView.rx.itemSelected
            .bindTo(viewModel.itemSelected).addDisposableTo(disposeBag)
        
        collectionView.rx.modelSelected(LocationRecord.self)
            .subscribe(onNext: { menu in
                
            })
            .addDisposableTo(disposeBag)
        
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
        
        setupConstraints()
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("app_name", comment: "")
    }
    
    func setupPostNewLocationBarButton() {
        let menuImage = UIImage(named: "ic_add_location_white")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handlePostNewLocationTap))
        navigationItem.rightBarButtonItems = [menuBarButtonItem]
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject) {
        viewModel.downloadLocations()
        refreshControl.endRefreshing()
    }
    
    func setupBackgroundImage() {
        backgroundImageLogo = UIImageView.init(image: UIImage(named: "img_asr_empty_state"))
        backgroundImageLogo.contentMode = .scaleAspectFit
        
        collectionView.backgroundColor = UIColor.grayBackgroundColor
        collectionView.backgroundView = backgroundImageLogo
    }
    
    func handlePostNewLocationTap() {
        viewModel.postNewLocationTapped()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 0)
    }
    
    func setupConstraints() {
        backgroundImageLogo.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(view)
        }
    }
}
