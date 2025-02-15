//
//  GHFEmptyStateView.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 14/02/2025.
//

import UIKit

class GHFEmptyStateView: UIView {

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty-state-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .systemBackground
        
        addSubview(messageLabel)
        addSubview(emptyStateImageView)
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        emptyStateImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.3)
            make.height.equalTo(self.snp.width).multipliedBy(1.3)
            make.leading.equalTo(100)
            make.bottom.equalToSuperview()
        }
    }
}
