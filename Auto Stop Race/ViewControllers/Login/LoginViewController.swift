//
//  LoginViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol LoginViewControllerDelegate: class {
    func loginButtonTapped()
    
}

class LoginViewController: UIViewControllerWithBackButton {
    
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = NSLocalizedString("hint_email", comment: "")
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = NSLocalizedString("hint_password", comment: "")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitle(NSLocalizedString("action_login", comment: "").uppercased(), for: .normal)
        button.backgroundColor = UIColor.blueMenu
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightUltraLight)
        button.addTarget(self, action: #selector(handleLoginTap), for: .touchUpInside)
        return button
    }()
    
    let resetPasswordButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitle(NSLocalizedString("action_reset_pass", comment: "").uppercased(), for: .normal)
        button.setTitleColor(UIColor.blueMenu, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightUltraLight)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(handleResetPasswordTap), for: .touchUpInside)
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let inputContainerView: UIView = {
        let stackView = UIView()
        stackView.backgroundColor = UIColor.white
        stackView.layer.cornerRadius = 5
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView.init(image: UIImage(named: "bg"))
        image.contentMode = .scaleAspectFill
        
        image.frame = self.view.frame
        
        return image
    }()


    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputContainerView.addSubview(usernameTextField)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(separatorView)

        stackView.addArrangedSubview(inputContainerView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(resetPasswordButton)
        
        view.backgroundColor = .black
        
        view.addSubview(stackView)

        view.addSubview(backgroundImage)
        view.sendSubview(toBack: backgroundImage)
        
        setupNavigationBarTitle()
        setupHelpBarButton()
        setupConstraints()
    }
    
    convenience init(viewModel: LoginViewModel) {
        self.init()
        
        self.viewModel = viewModel
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_login", comment: "")
    }
    
    func setupHelpBarButton() {
        let menuImage = UIImage(named: "ic_help_outline_white")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleHelpTap))
        navigationItem.rightBarButtonItems = [menuBarButtonItem]
    }
    
    func handleHelpTap() {
        let alert = UIAlertController(title: NSLocalizedString("menu_help", comment: ""), message:NSLocalizedString("msg_login_info", comment: "") , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleLoginTap() {

    }
    
    func handleResetPasswordTap() {
        
    }
    
    func setupConstraints() {
        inputContainerView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(128)
            make.width.equalTo(stackView)
        }
        
        usernameTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(inputContainerView).dividedBy(2)
            make.left.equalTo(inputContainerView).offset(20)
            make.top.right.equalTo(inputContainerView)
        }
        
        separatorView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(1)
            make.width.equalTo(inputContainerView)
            make.top.equalTo(usernameTextField.snp.bottom)
            make.left.right.equalTo(inputContainerView)
        }
        
        passwordTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(inputContainerView).dividedBy(2)
            make.left.equalTo(inputContainerView).offset(20)
            make.bottom.right.equalTo(inputContainerView)
        }
        
        loginButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(stackView)
            make.right.equalTo(stackView)
            make.height.equalTo(64)
        }
        
        resetPasswordButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(stackView)
            make.right.equalTo(stackView)
            make.height.equalTo(64)
        }
    
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(view).offset(32)
            make.left.equalTo(view).offset(32)
            make.right.equalTo(view).offset(-32)
            make.height.equalTo(view).dividedBy(2)
        }
    }
}
