//
//  MenuViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

class Menu: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class MenuViewController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let menu: [Menu] = {
            return [Menu(name: "title_my_team_locations", imageName: "ic_location_on_black"),
                    Menu(name: "title_activity_teams", imageName: "ic_map_black"),
                    Menu(name: "title_activity_campus", imageName: "ic_tent_black"),
                    Menu(name: "title_activity_phrasebook", imageName: "ic_message_black"),
                    Menu(name: "title_activity_contact", imageName: "ic_email_black"),
                    Menu(name: "title_activity_partners", imageName: "ic_favorite_black"),
                    Menu(name: "title_activity_settings", imageName: "ic_settings_black"),
                    Menu(name: "title_activity_about", imageName: "ic_info_black")]
    }()
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    }

    func showMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor.init(white:0, alpha:0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            collectionView.frame = CGRect.init(x: -300, y: 0, width: 300, height: window.frame.height)
            collectionView.backgroundColor = UIColor.blueMenu
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect.init(x: 0, y: 0, width: 280, height: window.frame.height)
            }, completion: nil)
        }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect.init(x: -300, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let menu = self.menu[indexPath.item]
        cell.menu = menu
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 20)
    }
}
