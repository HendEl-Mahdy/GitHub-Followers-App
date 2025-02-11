//
//  GHFAlertView.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 05/02/2025.
//

import UIKit

class GHFAlertView: UIView {
    
    private var closeButton: GHFButton?
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.white.cgColor
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLb = UILabel()
        titleLb.textAlignment = .center
        titleLb.font = UIFont.boldSystemFont(ofSize: 20)
        titleLb.textColor = .label
        titleLb.translatesAutoresizingMaskIntoConstraints = false
        return titleLb
    }()
    
    private lazy var messageLabel: UILabel = {
        let messageLb = UILabel()
        messageLb.textAlignment = .center
        messageLb.numberOfLines = 0
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
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        configureContainerView()
        configureTitleLabel()
        configureBodyLabel()
        configureCloseButton()
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let keyWindow = scene.windows.first else { return }
        frame = keyWindow.bounds
        keyWindow.addSubview(self)
    }
    
    private func configureContainerView() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    private func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(26)
        }
    }
    
    private func configureBodyLabel() {
        containerView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func configureCloseButton() {
        containerView.addSubview(closeButton!)
        closeButton?.addTarget(self, action: #selector(dismissAlertView), for: .touchUpInside)
        
        closeButton?.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().inset(20)
            
        }
    }
    
    @objc private func dismissAlertView(){
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
        }) { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
