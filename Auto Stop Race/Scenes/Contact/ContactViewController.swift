//
//  ContactViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 18.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ContactViewControllerDelegate: class {
    func contactSelected(contact: Contact)
}

class ContactViewController: UIViewControllerWithMenu, UICollectionViewDelegateFlowLayout {
    
    let cellHeight: CGFloat = 80
    var viewModel: ContactViewModel!
    
    let disposeBag = DisposeBag()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    let teamImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "asr_team"))
        return imageView
    }()

    convenience init(viewModel: ContactViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavigationBarTitle()
        setupTeamImage()
        setupCollectionView()
        
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: ContactCell.Identifier)

        viewModel.contacts
            .bind(to: collectionView.rx.items(cellIdentifier: ContactCell.Identifier, cellType: ContactCell.self)) { _, contact, cell in
                cell.contact = contact
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Contact.self)
            .bind(to: viewModel.modelSelected).disposed(by: disposeBag)
        
        viewModel.modelSelected
            .subscribe(onNext: { [weak self] clickedContact in
                guard let self = self else { return }
                self.contactSelected(contact: clickedContact )
            }).disposed(by: disposeBag)
                
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        setupConstraints()
    }
    
    func contactSelected(contact: Contact) {
        switch contact.type {
        case "phone_number":
            openUrl(urlString: "tel://\(contact.value)")
        case "sms":
            openUrl(urlString: "sms://\(contact.value)")
        case "email":
            openUrl(urlString: "mailto://\(contact.value)")
        case "web_page":
            openUrl(urlString: "\(contact.value)")
        case "instagram":
            openUrl(urlString: "\(contact.value)")
        default:
            break   
        }
    }

    func openUrl(urlString: String) {
        if let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
        }
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_contact", comment: "")
    }

    func setupTeamImage() {
        view.addSubview(teamImage)
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        teamImage.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(view)
            make.width.equalToSuperview()
            make.height.equalTo(teamImage.snp.width).multipliedBy( 426.0 / 827.0 )
        }
        
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(teamImage.snp.bottom)
            make.left.bottom.right.equalTo(view)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 0)
    }
}
