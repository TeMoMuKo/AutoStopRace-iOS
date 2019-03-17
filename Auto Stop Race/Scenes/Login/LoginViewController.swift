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
    
    let usernameTextField: UITextField = { textField in
        textField.backgroundColor = UIColor.white
        textField.placeholder = NSLocalizedString("hint_email", comment: "")
        textField.set(traits: .email)
        return textField
    }(UITextField())
    
    let passwordTextField: UITextField = { textField in
        textField.backgroundColor = UIColor.white
        textField.placeholder = NSLocalizedString("hint_password", comment: "")
        textField.set(traits: .password)
        return textField
    }(UITextField())
    
    let separatorView = SeparatorView()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("action_login", comment: "").uppercased(), for: .normal)
        button.theme.blueWhiteUltraLight()
        button.addTarget(self, action: #selector(handleLoginTap), for: .touchUpInside)
        return button
    }()
    
    let resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("action_reset_pass", comment: "").uppercased(), for: .normal)
        button.theme.whiteBlueUltraLight()
        button.addTarget(self, action: #selector(handleResetPasswordTap), for: .touchUpInside)
        return button
    }()
    
    let activityIndicator = UIActivityIndicatorView()
    
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
        stackView.layer.borderWidth = 1
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bg"))
        image.contentMode = .scaleAspectFill
        image.frame = view.frame
        image.clipsToBounds = true
        return image
    }()

    var progressHUD = ProgressHUD(text: NSLocalizedString("title_activity_login", comment: ""))

    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self

        viewModel.setUpAuthDetails(email: usernameTextField.rx.text.orEmpty.asDriver(),
                                   password: passwordTextField.rx.text.orEmpty.asDriver())
        
        viewModel.inputBackgroundColor
            .drive(onNext: { [weak self] color in
                guard let `self` = self else { return }
                UIView.animate(withDuration: 0.2) {
                    self.inputContainerView.layer.borderColor = color.cgColor
                }
            }).disposed(by: disposeBag)
        
        viewModel.credentialsValid
            .drive(onNext: { [weak self] valid in
                guard let `self` = self else { return }
                self.loginButton.isEnabled = valid
                self.loginButton.alpha = valid ? 1 : 0.5
            }).disposed(by: disposeBag)
        
        viewModel.activityIndicator
            .asObservable()
            .subscribe(onNext: { [weak self] active in
                guard let `self` = self else { return }
                active ? self.progressHUD.show() : self.progressHUD.hide()
            }).disposed(by: disposeBag)
        
        inputContainerView.addSubview(usernameTextField)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(separatorView)

        stackView.addArrangedSubview(inputContainerView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(resetPasswordButton)
        
        view.backgroundColor = .black
        
        view.addSubview(stackView)
        view.addSubview(progressHUD)

        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
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
    
    @objc func handleHelpTap() {
        let alert = UIAlertController(title: NSLocalizedString("menu_help", comment: ""), message: NSLocalizedString("msg_login_info", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleLoginTap() {
        viewModel.signIn(email: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    @objc func handleResetPasswordTap() {
        let alert = UIAlertController(title: NSLocalizedString("title_activity_reset_pass", comment: ""), message: NSLocalizedString("input_email_for_reset_message", comment: ""), preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = NSLocalizedString(NSLocalizedString("input_email_for_reset_placeholder", comment: ""), comment: "")
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let textField = alert.textFields![0] as UITextField
            let email = textField.text!
            self.viewModel.resetPassword(email: email)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupConstraints() {
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
            make.top.equalTo(view).offset(32)
            make.left.equalTo(view).offset(32)
            make.right.equalTo(view).offset(-32)
            make.height.equalTo(view).dividedBy(2)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
}
