//
//  PartnersViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 17.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

class PartnersViewController: UIViewControllerWithMenu, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let partners = [
        Partner(cellType:.text, value:NSLocalizedString("strategic_partners", comment: "")),
        Partner(cellType:.image, value:"strategic_partner_wro"),
        Partner(cellType:.image, value:"strategic_partner_kaufland"),
        Partner(cellType:.text, value:NSLocalizedString("gold_partners", comment: "")),
        Partner(cellType:.image, value:"gold_partner_tarczynski"),
        Partner(cellType:.image, value:"gold_partner_grzeski"),
        Partner(cellType:.image, value:"gold_partner_profi_lingua"),
        Partner(cellType:.image, value:"gold_partner_akvo_active"),
        Partner(cellType:.image, value:"gold_partner_capoeira"),
        Partner(cellType:.image, value:"gold_partner_wachtigall"),
        Partner(cellType:.image, value:"gold_partner_cafe_borowka"),
        Partner(cellType:.text, value:NSLocalizedString("silver_partners", comment: "")),
        Partner(cellType:.image, value:"silver_partner_profi"),
        Partner(cellType:.image, value:"silver_partner_71zona"),
        Partner(cellType:.image, value:"silver_partner_meray"),
        Partner(cellType:.image, value:"silver_partner_hydropolis"),
        Partner(cellType:.image, value:"silver_partner_krav_maga"),
        Partner(cellType:.image, value:"silver_partner_lirene"),
        Partner(cellType:.image, value:"silver_partner_motyla_noga"),
        Partner(cellType:.image, value:"silver_partner_beactive"),
        Partner(cellType:.image, value:"silver_partner_el_sueno")
    ]
    
    let textCellHeight: CGFloat = 100
    let imageCellHeight: CGFloat = 200
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(PartnerImageCell.self, forCellWithReuseIdentifier: PartnerImageCell.Identifier)
        collectionView.register(PartnerTextCell.self, forCellWithReuseIdentifier: PartnerTextCell.Identifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavigationBarTitle()

        setupCollectionView()
        
        view.backgroundColor = UIColor.white
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_partners", comment: "")
    }
    
    func setupCollectionView() {
        collectionView.frame = view.frame
        collectionView.backgroundColor = UIColor.white
        
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if partners[indexPath.row].cellType == .image {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartnerImageCell.Identifier, for: indexPath) as! PartnerImageCell
            cell.imageView.image = UIImage(named: partners[indexPath.row].value)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartnerTextCell.Identifier, for: indexPath) as! PartnerTextCell
            cell.textLabel.text = partners[indexPath.row].value
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if partners[indexPath.row].cellType == .image {
            return CGSize.init(width: collectionView.frame.width, height: imageCellHeight)
        } else {
            return CGSize.init(width: collectionView.frame.width, height: textCellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 100)
    }

}
