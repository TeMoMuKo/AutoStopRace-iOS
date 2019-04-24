//
//  PartnersViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 17.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import WebKit

class PartnersViewController: UIViewControllerWithMenu, WKNavigationDelegate {

    let textCellHeight: CGFloat = 100
    let imageCellHeight: CGFloat = 200
    
    let webView = WKWebView()
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle()
        setupWevView()
        setupActivityIndicator()

        view.backgroundColor = UIColor.white
    }
    
    private func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_partners", comment: "")
    }

    private func setupActivityIndicator() {
        activityIndicator.color = #colorLiteral(red: 0.09183036536, green: 0.5070793033, blue: 0.8384359479, alpha: 1)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
    }
    
    private func setupWevView() {
        webView.navigationDelegate = self

        webView.frame = view.frame
        webView.backgroundColor = UIColor.white

        view.addSubview(webView)

        if let url = URL(string: "https://app.autostoprace.pl/raceinfo/partners/") {
            webView.load(URLRequest(url: url))
        }
    }

    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        activityIndicator.removeFromSuperview()
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        guard url != nil else {
            decisionHandler(.allow)
            return
        }

        if let url = url,
            url.absoluteString != "https://app.autostoprace.pl/raceinfo/partners/" {
            decisionHandler(.cancel)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            decisionHandler(.allow)
        }
    }
}
