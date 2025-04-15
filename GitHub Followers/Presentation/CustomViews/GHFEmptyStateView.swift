//
//  GHFEmptyStateView.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 14/02/2025.
//

import UIKit

/// A custom UIView used to display an empty state message and image.
/// This view is shown when there is no data to display, such as when a user has no followers.
class GHFEmptyStateView: UIView {

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = AppConstants.numberOfLines
        label.textAlignment = .center
        label.font = AppConstants.emptyStateMessageFont
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppConstants.emptyStateImageViewImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(AppConstants.initialError)
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
            make.top.equalToSuperview().inset(AppConstants.emptyStateMessageTopSpacing)
            make.leading.trailing.equalToSuperview().inset(AppConstants.emptyStateMessageHorizontalPadding)
        }
        
        emptyStateImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(AppConstants.emptyStateImageWidthMultiplier)
            make.height.equalTo(self.snp.width).multipliedBy(AppConstants.emptyStateImageHightMultiplier)
            make.leading.equalTo(AppConstants.emptyStateImageLeading)
            make.bottom.equalToSuperview()
        }
    }
}
