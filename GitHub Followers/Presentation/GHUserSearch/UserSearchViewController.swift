//
//  UserSearchViewController.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 04/02/2025.
//

import UIKit
import SnapKit
import RxSwift

/// A view controller for searching GitHub users and navigating to their followers list.
class UserSearchViewController: UIViewController {
    
    private let viewModel: UserSearchProtocol = UserSearchViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var usernameTextField = GHFTextField()
    private lazy var followersButton = GHFButton(backgroundColor: .systemGreen, buttonTitle: AppConstants.getFollowersButtonTitle)
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: AppConstants.logoImageName)
        return imageView
    }()
    
    //MARK: - App LifeCycle
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
        usernameTextField.text = AppConstants.emptyString
    }
    
    // MARK: - Views Configurations
    private func configureLogoImageView(){
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(AppConstants.logoTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(AppConstants.logoWidthMultiplier)
            make.height.equalToSuperview().multipliedBy(AppConstants.logoHeightMultiplier)
        }
    }
    
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(AppConstants.usernameTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(AppConstants.usernameWidthMultiplier)
            make.height.equalToSuperview().multipliedBy(AppConstants.usernameHeightMultiplier)
        }
    }
    
    private func configureFollowersButton(){
        view.addSubview(followersButton)
        followersButton.addTarget(self, action: #selector(followersButtonAction), for: .touchUpInside)
        
        followersButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(AppConstants.followersButtonTopOffset)
            make.width.equalToSuperview().multipliedBy(AppConstants.followersButtonWidthMultiplier)
            make.height.equalToSuperview().multipliedBy(AppConstants.followersButtonHeightMultiplier)
        }
    }
    
    private func setupBinding(){
        viewModel.userInfoDriver.drive(
            onNext: { [weak self] result in
                switch result {
                case .success(let username):
                    let followersListVC = FollowersListViewController()
                    followersListVC.username = username
                    self?.navigationController?.pushViewController(followersListVC, animated: true)
                case .failure(let error):
                    let _ = GHFAlertView(
                        tiltle: AppConstants.GHFAlertViewTitle,
                        message: error.errorMessage,
                        buttonTitle: AppConstants.GHFAlertViewButtonTitle
                    )
                }
            }).disposed(by: disposeBag)
    }
    
    @objc private func followersButtonAction(){
        view.endEditing(true)
        viewModel.getUserInfo(username: usernameTextField.text!)
    }
    
    // MARK: - Keyboard Configuration
    /// Configures keyboard behavior, including tap gestures and notifications.
    private func configureKeyboardBehavior(){
        setupDismissKeyBoardTapGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Sets up a tap gesture to dismiss the keyboard.
    private func setupDismissKeyBoardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    /// Animates the view upward when the keyboard appears.
    /// - Parameter notification: The notification containing keyboard information.
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            UIView.animate(withDuration: AppConstants.keyboardAnimationDuration) {
                self.view.transform = CGAffineTransform(translationX: CGFloat(AppConstants.zero), y: -keyboardHeight / AppConstants.keyboardHeightDivider)
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: AppConstants.keyboardAnimationDuration) {
            self.view.transform = .identity
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

/// Extension to handle text field delegate methods.
extension UserSearchViewController: UITextFieldDelegate {
    
    /// Handles the return key press by triggering the followers button action.
    /// - Parameter textField: The text field that received the return key press.
    /// - Returns: True to allow the return key action.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        followersButtonAction()
        return true
    }
}
