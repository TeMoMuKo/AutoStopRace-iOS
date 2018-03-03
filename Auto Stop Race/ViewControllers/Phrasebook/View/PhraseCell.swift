//
//  PhraseCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 21.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class PhraseCell: UITableViewCell {
    static let Identifier = "PhraseCell"
    
    var whiteRoundedView: UIView!

    private var disposeBag = DisposeBag()

    var viewModel: PhraseViewModelType? {
        willSet {
            disposeBag = DisposeBag()
        }
        didSet {
            setupBindings()
        }
    }
    
    func setupBindings() {
        viewModel?.polishPhrase.asObservable().bind(to: polishPhraseLabel.rx.text).disposed(by: disposeBag)
        viewModel?.currentTranslationPhrase.asObservable().bind(to: translationPhraseLabel.rx.text).disposed(by: disposeBag)
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_message_black"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var polishPhraseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var translationPhraseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var translationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.Color.grayBackground
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        let view = UIView()
        view.backgroundColor = Theme.Color.blueMenu
        selectedBackgroundView = view
        contentView.backgroundColor = UIColor.clear
        selectionStyle = .none
        
        whiteRoundedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.layer.frame.size.width, height: 80)))
        whiteRoundedView.layer.backgroundColor = CGColor.init(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.5
        
        contentView.addSubview(whiteRoundedView)
        contentView.sendSubview(toBack: whiteRoundedView)
        
        addSubview(translationBackgroundView)
        addSubview(iconImageView)
        addSubview(polishPhraseLabel)
        addSubview(translationPhraseLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        whiteRoundedView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview()
        }
        
        translationBackgroundView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(polishPhraseLabel).offset(-10)
            make.right.equalTo(self)
            make.height.equalTo(0.5)
        }
        
        polishPhraseLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self).multipliedBy(0.75)
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.right.equalToSuperview().offset(-10)
        }
        
        translationPhraseLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self).multipliedBy(1.25)
            make.left.equalTo(polishPhraseLabel)
            make.right.equalToSuperview().offset(-10)
        }
        
        iconImageView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(29)
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
    }
}
