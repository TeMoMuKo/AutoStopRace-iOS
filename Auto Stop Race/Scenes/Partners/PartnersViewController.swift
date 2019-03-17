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
        Partner(cellType: .text, value: NSLocalizedString("strategic_partners", comment: "")),
        Partner(cellType: .image, value: "strategic/kaufland"),
        Partner(cellType: .image, value: "strategic/auto24"),
        Partner(cellType: .text, value: NSLocalizedString("gold_partners", comment: "")),
        Partner(cellType: .image, value: "gold/wachitgall"),
        Partner(cellType: .image, value: "gold/hatchi"),
        Partner(cellType: .image, value: "gold/mamut"),
        Partner(cellType: .image, value: "gold/akvo"),
        Partner(cellType: .image, value: "gold/luba"),
        Partner(cellType: .image, value: "gold/sygnet"),
        Partner(cellType: .image, value: "gold/decathlon"),
        Partner(cellType: .text, value: NSLocalizedString("silver_partners", comment: "")),
        Partner(cellType: .image, value: "silver/profi"),
        Partner(cellType: .image, value: "silver/lovex"),
        Partner(cellType: .image, value: "silver/snowz"),
        Partner(cellType: .image, value: "silver/kravmaga"),
        Partner(cellType: .image, value: "silver/burgerking"),
        Partner(cellType: .image, value: "silver/narny"),
        Partner(cellType: .image, value: "silver/beskidzkie"),
        Partner(cellType: .image, value: "silver/findyourbuddy"),
        Partner(cellType: .image, value: "silver/tacoslocos"),
        Partner(cellType: .text, value: NSLocalizedString("bronze_partners", comment: "")),
        Partner(cellType: .image, value: "bronze/sonko"),
        Partner(cellType: .image, value: "bronze/irenki"),
        Partner(cellType: .image, value: "bronze/sandmix"),
        Partner(cellType: .image, value: "bronze/funsurf"),
        Partner(cellType: .image, value: "bronze/sjos"),
        Partner(cellType: .image, value: "bronze/spocket"),
        Partner(cellType: .image, value: "bronze/unicarcapoeira"),
        Partner(cellType: .image, value: "bronze/setenta"),
        Partner(cellType: .image, value: "bronze/gorczanska"),
        Partner(cellType: .image, value: "bronze/yourtemporarytattoos"),
        Partner(cellType: .image, value: "bronze/elsueno"),
        Partner(cellType: .image, value: "bronze/inkblink"),
        Partner(cellType: .text, value: NSLocalizedString("supporting_partners", comment: "")),
        Partner(cellType: .image, value: "supporting/domekzkart"),
        Partner(cellType: .image, value: "supporting/albi"),
        Partner(cellType: .image, value: "supporting/lereve"),
        Partner(cellType: .image, value: "supporting/wydrukujemyto"),
        Partner(cellType: .image, value: "supporting/bezdroza"),
        Partner(cellType: .image, value: "supporting/ksiegarniapodroznika"),
        Partner(cellType: .image, value: "supporting/gojump"),
        Partner(cellType: .image, value: "supporting/cudawianki"),
        Partner(cellType: .image, value: "supporting/samart"),
        Partner(cellType: .image, value: "supporting/tkalniazagadek"),
        Partner(cellType: .image, value: "supporting/mobicafe"),
        Partner(cellType: .image, value: "supporting/hdprint"),
        Partner(cellType: .image, value: "supporting/crashball"),
        Partner(cellType: .image, value: "supporting/squash"),
        Partner(cellType: .image, value: "supporting/zona71"),
        Partner(cellType: .image, value: "supporting/oriflame"),
        Partner(cellType: .text, value: NSLocalizedString("honorary_partners", comment: "")),
        Partner(cellType: .image, value: "honorary/uewroc"),
        Partner(cellType: .image, value: "honorary/samorzad"),
        Partner(cellType: .text, value: NSLocalizedString("technical_partners", comment: "")),
        Partner(cellType: .image, value: "technical/smscenter"),
        Partner(cellType: .image, value: "technical/sendingo"),
        Partner(cellType: .image, value: "technical/damianmekal"),
        Partner(cellType: .image, value: "technical/paramed"),
        Partner(cellType: .image, value: "technical/mavmedia"),
        Partner(cellType: .text, value: NSLocalizedString("talk_about_us", comment: "")),
        Partner(cellType: .image, value: "talk_about_us/nationalgeographic"),
        Partner(cellType: .image, value: "talk_about_us/meloradio"),
        Partner(cellType: .image, value: "talk_about_us/luz"),
        Partner(cellType: .image, value: "talk_about_us/radiogra"),
        Partner(cellType: .text, value: NSLocalizedString("media_partnet", comment: "")),
        Partner(cellType: .image, value: "media/eska")
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

        setupNavigationBarTitle()
        setupCollectionView()
        
        view.backgroundColor = UIColor.white
    }
    
    private func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_partners", comment: "")
    }
    
    private func setupCollectionView() {
        collectionView.register(PartnerImageCell.self, forCellWithReuseIdentifier: PartnerImageCell.Identifier)
        collectionView.register(PartnerTextCell.self, forCellWithReuseIdentifier: PartnerTextCell.Identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

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
            return CGSize(width: collectionView.frame.width, height: imageCellHeight)
        } else {
            return CGSize(width: collectionView.frame.width, height: textCellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }

}
