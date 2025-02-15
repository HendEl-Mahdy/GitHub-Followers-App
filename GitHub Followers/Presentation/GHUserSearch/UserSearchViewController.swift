//
//  UserSearchViewController.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 04/02/2025.
//

import UIKit
import SnapKit
import RxSwift

class UserSearchViewController: UIViewController {
    
    private let viewModel: UserSearchProtocol = UserSearchViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var usernameTextField = GHFTextField()
    private lazy var followersButton = GHFButton(backgroundColor: .systemGreen, buttonTitle: "Get Followers")
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gh-logo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureUsernameTextField()
        configureFollowersButton()
        configureKeyboardBehavior()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.text = ""
    }
    
    // MARK: - Views Configurations
    private func configureLogoImageView(){
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(90)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
    }
    
    private func configureFollowersButton(){
        view.addSubview(followersButton)
        followersButton.addTarget(self, action: #selector(followersButtonAction), for: .touchUpInside)
        
        followersButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(70)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
    }
    
    private func setupBinding(){
        viewModel.userInfoDriver.drive(onNext: { [weak self] result in
            switch result {
            case .success(let username):
                let followersListVC = FollowersListViewController()
                followersListVC.username = username
                self?.navigationController?.pushViewController(followersListVC, animated: true)
            case .failure(let error):
                let _ = GHFAlertView(tiltle: "Something went wrong", message: error.errorMessage, buttonTitle: "OK")
            }
        }).disposed(by: disposeBag)
    }
    
    @objc private func followersButtonAction(){
        view.endEditing(true)
        viewModel.getUserInfo(username: usernameTextField.text!)
    }
    
    // MARK: - Keyboard Configuration
    private func configureKeyboardBehavior(){
        setupDismissKeyBoardTapGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDismissKeyBoardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            UIView.animate(withDuration: 0.3) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight / 4)
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension UserSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        followersButtonAction()
        return true
    }
}
