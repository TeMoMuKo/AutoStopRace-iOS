//
//  MenuViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MenuViewControllerDelegate: class {
    func menuSelected(menu: MenuDestination)
}

class MenuViewController: NSObject, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    var viewModel: MenuViewModel!
    
    let disposeBag = DisposeBag()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    let cellHeight: CGFloat = 50
    
    init(viewModel: MenuViewModel) {
        super.init()
        
        self.viewModel = viewModel
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.Identifier)

        viewModel.menu.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: MenuCell.Identifier, cellType: MenuCell.self)) { _, menu, cell in
                cell.menu = menu
        }
        .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind(to: viewModel.itemSelected).disposed(by: disposeBag)

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        if let window = UIApplication.shared.keyWindow {
            let swipeBackGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss))
            swipeBackGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.left
            window.addGestureRecognizer(swipeBackGestureRecognizer)
        }
    }

    func showMenu() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            collectionView.frame = CGRect(x: -300, y: 0, width: 300, height: window.frame.height)
            collectionView.backgroundColor = Theme.Color.blueMenu
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: 0, width: 280, height: window.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            
            if UIApplication.shared.keyWindow != nil {
                self.collectionView.frame = CGRect(x: -300, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        })
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if UIApplication.shared.keyWindow != nil {
                self.collectionView.frame = CGRect(x: -300, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        })
    }
}
