//
//  PhrasebookViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhrasebookViewController: UIViewControllerWithMenu, UITableViewDelegate {
    var shownPhrases: [String] = ["Test"]
    
    var viewModel: PhrasebookViewModel!
    let disposeBag = DisposeBag()
    
    let wordSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.blueMenu
        return searchBar
    }()
    
    let segmentedControlView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let languageSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.tintColor = UIColor.blueMenu
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    let phrasesTableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    convenience init(viewModel: PhrasebookViewModel) {
        self.init()
        
        self.viewModel = viewModel
        
        phrasesTableView.register(PhraseCell.self, forCellReuseIdentifier: PhraseCell.Identifier)
        
        viewModel.languages.asObservable()
            .map { $0 }
            .subscribe(onNext: {[weak self] titles in
                guard let `self` = self else { return }

                for title in titles {
                    if title != "polski" {
                        self.languageSegmentedControl.insertSegment(withTitle: title, at: self.languageSegmentedControl.numberOfSegments, animated: true)
                    }
                }
                self.languageSegmentedControl.selectedSegmentIndex = 0
            }).addDisposableTo(disposeBag)
        
        
        wordSearchBar.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {[weak self] query in
                guard let _ = self else { return }
                viewModel.phrases.value = viewModel.allPhrases.filter { phrase in
                    if query.isEmpty {
                        return true
                    } else {
                        let isInPolishPhrase = phrase.polishPhrase.lowercased().contains(query.lowercased())
                        let isInTranslationPhrase = phrase.currentTranslationPhrase.lowercased().contains(query.lowercased())
                        return isInPolishPhrase || isInTranslationPhrase
                    }
                }.map { ($0, PhraseViewModel(phrase: $0)) }
            }).addDisposableTo(disposeBag)
        
        languageSegmentedControl.rx.selectedSegmentIndex.asObservable()
            .subscribe(onNext: {[weak self] selectedIndex in
                guard let _ = self else { return }
                    for (phrase, phraseViewModel) in viewModel.phrases.value  {
                        phraseViewModel.currentTranslationPhrase.value = phrase.translationPhrases[selectedIndex]
                    }
                }).addDisposableTo(disposeBag)

        viewModel.phrasesObservable
            .bindTo(phrasesTableView.rx.items) { tableView, i, item in
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: PhraseCell.Identifier, for: indexPath) as! PhraseCell
                cell.viewModel = item
                return cell
            }.addDisposableTo(disposeBag)
        
        phrasesTableView.separatorStyle = .none

        phrasesTableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitle()
        
        view.addSubview(phrasesTableView)
        view.addSubview(segmentedControlView)
        view.addSubview(languageSegmentedControl)
        view.addSubview(wordSearchBar)
                
        setupConstraints()
    }

    func setupConstraints() {
        wordSearchBar.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(view)
            make.height.equalTo(self.navigationController!.navigationBar.frame.height)
        }
        
        segmentedControlView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(wordSearchBar.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(self.navigationController!.navigationBar.frame.height)
        }
        
        languageSegmentedControl.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(segmentedControlView).offset(9)
            make.left.equalTo(segmentedControlView).offset(9)
            make.right.equalTo(segmentedControlView).offset(-9)
        }
        
        phrasesTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(segmentedControlView.snp.bottom)
            make.left.bottom.right.equalTo(view)
        }
    }

    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_phrasebook", comment: "")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


