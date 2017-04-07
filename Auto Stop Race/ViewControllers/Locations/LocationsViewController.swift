//
//  LocationsViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 18.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import GoogleMaps
import RxSwift
import RxCocoa

class LocationsViewController: UIViewControllerWithMenu, UICollectionViewDelegateFlowLayout {
    let cellHeight: CGFloat = 80

    var viewModel: LocationsViewModel!

    let locationsSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.blueMenu
        return searchBar
    }()
    
    let teamsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    var heightConstraint: Constraint? = nil

    var mapView: GMSMapView!
    
    private let disposeBag = DisposeBag()
    
    convenience init(viewModel: LocationsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGMSServices()
        setupNavigationBarTitle()
        setupSearchBar()
        setupDropDownList()
        setupKeyboard()
        setupConstraints()
    }
    
    func setupGMSServices() {
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            let GMSServicesAPIKey = dict["GMSServicesAPIKey"] as? String
            GMSServices.provideAPIKey(GMSServicesAPIKey!)
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(GMSConfig.initialLatitude), longitude: CLLocationDegrees(GMSConfig.initialLongitude), zoom: Float(GMSConfig.initialZoom))
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view.addSubview(mapView)
    }

    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_teams", comment: "")
    }
    
    func setupSearchBar() {
        let textfield:UITextField = locationsSearchBar.value(forKey:"searchField") as! UITextField
        
        let attributedString = NSAttributedString(string: NSLocalizedString("hint_enter_team_number", comment: ""), attributes: [NSForegroundColorAttributeName : UIColor.lightGray])
        
        textfield.attributedPlaceholder = attributedString
        
        view.addSubview(locationsSearchBar)
    }
    
    
    
    func setupDropDownList() {
        teamsCollectionView.register(TeamLocationCell.self, forCellWithReuseIdentifier: TeamLocationCell.Identifier)

        viewModel.shownTeams.asObservable()
            .bindTo(teamsCollectionView.rx.items(cellIdentifier: TeamLocationCell.Identifier, cellType: TeamLocationCell.self)) { (row, team, cell) in
                cell.team = team
            }
            .disposed(by: disposeBag)
        
        locationsSearchBar.rx.text.orEmpty
            .subscribe(onNext: { [weak self] query in
                guard let `self` = self else { return }
                if query.isEmpty {
                    self.viewModel.shownTeams.value = self.viewModel.allTeams.value
                } else {
                    self.viewModel.shownTeams.value = self.viewModel.allTeams.value.filter { $0.teamNumber == Int(query) }
                }
                self.updateConstraints()
            })
            .disposed(by: disposeBag)
        
        teamsCollectionView.rx.setDelegate(self).addDisposableTo(disposeBag)

        view.addSubview(teamsCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func setupKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        if let window = UIApplication.shared.keyWindow {
            window.addGestureRecognizer(tap)
        }
    }
    
    func updateConstraints() {
        var cellsCount = self.viewModel.shownTeams.value.count
        self.heightConstraint?.update(offset: (cellsCount < 4 ? cellsCount : 4) * 80)
    }
    
    func setupConstraints() {
        teamsCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(locationsSearchBar.snp.bottom)
            self.heightConstraint = make.height.equalTo(0).constraint
            make.width.equalTo(view)
            make.left.right.equalTo(view)
        }
        
        locationsSearchBar.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(view)
            make.height.equalTo(self.navigationController!.navigationBar.frame.height)
        }
        
        mapView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(locationsSearchBar.snp.bottom)
            make.left.bottom.right.equalTo(view)
        }
    }
    func dismissKeyboard() {
        locationsSearchBar.resignFirstResponder()
    }

}
