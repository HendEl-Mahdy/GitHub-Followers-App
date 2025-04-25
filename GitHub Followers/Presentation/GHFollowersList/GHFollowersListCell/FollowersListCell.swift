//
//  FollowersListCell.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 10/02/2025.
//

import UIKit

/// A custom collection view cell used to display a follower's avatar and username.
class FollowersListCell: UICollectionViewCell {
    static let identifier = AppConstants.followersCellIdentifier
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: AppConstants.followersCellImagePlaceholder)
        image.layer.cornerRadius = AppConstants.followersCellImageCornerRadius
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = AppConstants.followersCellUsernameFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError(AppConstants.initialError)
    }
    
    private func configureCell(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(AppConstants.followersCellAvatarTopOffset)
            make.leading.trailing.equalToSuperview().inset(AppConstants.followersCellAvatarHorizontalInset)
            make.height.equalTo(avatarImageView.snp.width)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(AppConstants.followersCellUsernameTopOffset)
            make.leading.trailing.equalToSuperview().inset(AppConstants.followersCellUsernameHorizontalInset)
            make.height.equalTo(AppConstants.followersCellUsernameHeight)
        }
    }
    
    /// Configures the cell with data from a `Follower` object.
    /// - Parameter follower: The follower object containing the username and avatar URL.
    func setFollower(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
}
