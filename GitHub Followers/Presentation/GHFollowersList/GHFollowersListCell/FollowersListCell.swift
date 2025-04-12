//
//  FollowersListCell.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 10/02/2025.
//

import UIKit

class FollowersListCell: UICollectionViewCell {
    static let identifier = "followersCell"
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar-placeholder")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFollower(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configureCell(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(avatarImageView.snp.width)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
    }
    
}
