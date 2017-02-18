//
//  PartnersViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 17.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

class PartnersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let partnersImagesNames = ["logo_beactive", "logo_cafe_borowka", "logo_express", "logo_cafe_borowka", "logo_grzeski", "logo_kf", "logo_kravmaga", "logo_lerni"]
    
    let cellHeight: CGFloat = 250

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(PartnerCell.self, forCellWithReuseIdentifier: PartnerCell.Identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavigationBar()
        setupNavigationBarButtons()
        setupCollectionView()
        
        view.backgroundColor = UIColor.white
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        navigationItem.titleView = titleLabel
        titleLabel.text = NSLocalizedString("title_partners", comment: "")
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    func setupNavigationBarButtons() {
        let menuImage = UIImage(named: "menu_icon")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
    }
    
    func handleMenu() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appCoordinator = appDelegate.coordinator as! AppCoordinator
        appCoordinator.menuSelected()
    }
    
    func setupCollectionView() {
        collectionView.frame = view.frame
        collectionView.backgroundColor = UIColor.white
        
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partnersImagesNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartnerCell.Identifier, for: indexPath) as! PartnerCell
        cell.imageView.image = UIImage(named: partnersImagesNames[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 100)
    }

}
