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

class LocationsViewController: UIViewControllerWithMenu, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, GMSMapViewDelegate  {
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

    var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(GMSConfig.initialLatitude), longitude: CLLocationDegrees(GMSConfig.initialLongitude), zoom: Float(GMSConfig.initialZoom))
        let map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return map
    }()
    
    private let disposeBag = DisposeBag()
    
    convenience init(viewModel: LocationsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationsSearchBar.delegate = self
        mapView.delegate = self

        setupGMSServices()
        setupNavigationBarTitle()
        setupSearchBar()
        setupDropDownList()
        setupKeyboard()
        setupConstraints()
    }
    
    func setupGMSServices() {
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.viewModel.shownTeams.value = self.viewModel.allTeams.value
        updateConstraints()
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
        
        teamsCollectionView.rx.modelSelected(Team.self)
            .bindTo(viewModel.teamSelected).addDisposableTo(disposeBag)
        
        viewModel.teamSelected
            .subscribe(onNext: { [weak self] team in
                guard let `self` = self else { return }
                
                self.teamSelected(team: team )
            })
            .addDisposableTo(disposeBag)
        
        view.addSubview(teamsCollectionView)
    }
    
    func teamSelected(team: Team) {
        if viewModel.userTeamNumber != nil && team.teamNumber == viewModel.userTeamNumber{
            showUserMarkers()
        } else {
            showMarker(team: team)
        }
    }
    
    func showUserMarkers() {
        mapView.clear()
        for userLocation in viewModel.locationRecords.value {
            let position = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
            let marker = GMSMarker(position: position)
            let markerView = UIImageView(image: #imageLiteral(resourceName: "asr_marker"))
            marker.iconView = markerView
            marker.title = userLocation.message
            marker.snippet = userLocation.created_at.toString(withFormat: DateFormat.fullMap)
            marker.map = mapView
        }
        self.viewModel.shownTeams.value = []
        updateConstraints()
    }
    
    func showMarker(team: Team) {
        mapView.clear()

        let position = CLLocationCoordinate2D(latitude: team.lastLocation.latitude, longitude: team.lastLocation.longitude)
        mapView.animate(toLocation: position)
        let marker = GMSMarker(position: position)
        let markerView = UIImageView(image: #imageLiteral(resourceName: "asr_marker"))
        marker.iconView = markerView
        marker.title = team.lastLocation.message
        marker.snippet = team.lastLocation.created_at.toString(withFormat: DateFormat.fullMap)
        marker.map = mapView
        self.viewModel.shownTeams.value = []
        updateConstraints()
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
        let cellsCount = self.viewModel.shownTeams.value.count
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
