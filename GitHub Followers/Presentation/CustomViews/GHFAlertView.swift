//
//  GHFAlertView.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 05/02/2025.
//

import UIKit

/// A custom alert view for displaying messages with a title, body, and dismiss button`GHFButton`.
class GHFAlertView: UIView {
    
    private var closeButton: GHFButton?
    /// The container view that holds the alert's content (title, message, button).
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = AppConstants.containerViewCornerRadius
        container.layer.borderWidth = AppConstants.containerViewBorderWidth
        container.layer.borderColor = UIColor.white.cgColor
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLb = UILabel()
        titleLb.textAlignment = .center
        titleLb.font = UIFont.boldSystemFont(ofSize: AppConstants.alertTitleLabelFontSize)
        titleLb.textColor = .label
        titleLb.translatesAutoresizingMaskIntoConstraints = false
        return titleLb
    }()
    
    private lazy var messageLabel: UILabel = {
        let messageLb = UILabel()
        messageLb.textAlignment = .center
        messageLb.numberOfLines = AppConstants.numberOfLines
        messageLb.font = UIFont.preferredFont(forTextStyle: .body)
        messageLb.textColor = .secondaryLabel
        messageLb.translatesAutoresizingMaskIntoConstraints = false
        return messageLb
    }()
    
    init(tiltle: String, message: String, buttonTitle: String){
        super.init(frame: .zero)
        closeButton = GHFButton(backgroundColor: .systemRed, buttonTitle: buttonTitle)
        titleLabel.text = tiltle
        messageLabel.text = message
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(AppConstants.initialError)
    }
    
    private func setupView(){
        backgroundColor = AppConstants.alertBackgroundColor
        configureContainerView()
        configureTitleLabel()
        configureBodyLabel()
        configureCloseButton()
        moveViewToFront()
    }
    
    private func configureContainerView() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(AppConstants.containerViewWidthMultiplier)
        }
    }
    
    private func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppConstants.alertTitleLabelTopSpacing)
            make.leading.trailing.equalToSuperview().inset(AppConstants.alertTitleLabelHorizontalPadding)
            make.height.equalTo(AppConstants.alertTitleLabelHeight)
        }
    }
    
    private func configureBodyLabel() {
        containerView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppConstants.alertMessageLabelTopSpacing)
            make.leading.trailing.equalToSuperview().inset(AppConstants.alertMessageLabelHorizontalPadding)
        }
    }
    
    private func configureCloseButton() {
        containerView.addSubview(closeButton!)
        closeButton?.addTarget(self, action: #selector(dismissAlertView), for: .touchUpInside)
        
        closeButton?.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(AppConstants.alertButtonTopSpacing)
            make.leading.trailing.equalToSuperview().inset(AppConstants.alertButtonHorizontalPadding)
            make.bottom.equalToSuperview().inset(AppConstants.alertButtonBottomSpacing)
            make.height.equalTo(AppConstants.alertButtonHeight)
        }
    }
    
    /// Adds the alert view to the application's key window and brings it to the front.
    private func moveViewToFront() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let keyWindow = scene.windows.first else { return }
        frame = keyWindow.bounds
        keyWindow.addSubview(self)
    }
    
    @objc private func dismissAlertView(){
        UIView.animate(withDuration: AppConstants.alertDismissDuration, animations: { [weak self] in
            self?.alpha = AppConstants.alertDismissAlpha
        }) { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
