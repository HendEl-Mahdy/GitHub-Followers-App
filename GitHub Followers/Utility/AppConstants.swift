//
//  AppConstants.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 04/02/2025.
//

import UIKit

struct AppConstants {
    
    // MARK: GHFButton
    static let ButtonCornerRadius: CGFloat = 10
    
    // MARK: - GHFTextField
    static let textFieldPlaceholder = "Username"
    static let textFieldCornerRadius: CGFloat = 10
    static let textFieldBorderWidth: CGFloat = 2
    
    // MARK: - GHFAlertView
    // Container View
    static let containerViewCornerRadius: CGFloat = 16
    static let containerViewBorderWidth: CGFloat = 2
    static let containerViewWidthMultiplier: CGFloat = 0.8
    // Title Label
    static let alertTitleLabelFontSize: CGFloat = 20
    static let alertTitleLabelHeight: CGFloat = 26
    static let alertTitleLabelTopSpacing: CGFloat = 20
    static let alertTitleLabelHorizontalPadding: CGFloat = 10
    // Message Label
    static let alertMessageLabelTopSpacing: CGFloat = 18
    static let alertMessageLabelHorizontalPadding: CGFloat = 30
    static let numberOfLines = 0
    // Button
    static let alertButtonHeight: CGFloat = 45
    static let alertButtonTopSpacing: CGFloat = 30
    static let alertButtonBottomSpacing: CGFloat = 20
    static let alertButtonHorizontalPadding: CGFloat = 40
    // Alert View
    static let alertBackgroundColor = UIColor.black.withAlphaComponent(0.5)
    static let alertDismissDuration: TimeInterval = 0.3
    static let alertDismissAlpha: CGFloat = 0
    
    // MARK: - GHFEmptyStateView
    // Message Label
    static let emptyStateMessageFont = UIFont.boldSystemFont(ofSize: 26)
    static let emptyStateMessageTopSpacing: CGFloat = 200
    static let emptyStateMessageHorizontalPadding: CGFloat = 50
    // Empty State Image View
    static let emptyStateImageViewImage = UIImage(named: "empty-state-logo")
    static let emptyStateImageWidthMultiplier = 1.3
    static let emptyStateImageHightMultiplier = 1.3
    static let emptyStateImageLeading = 100
    
    //MARK: - GitHubUserSearchVC
    static let getFollowersButtonTitle = "Get Followers"
    static let logoImageName = "gh-logo"
    static let emptyString = ""
    static let logoTopOffset: CGFloat = 90
    static let logoWidthMultiplier: CGFloat = 0.65
    static let logoHeightMultiplier: CGFloat = 0.3
    static let usernameTopOffset: CGFloat = 50
    static let usernameWidthMultiplier: CGFloat = 0.65
    static let usernameHeightMultiplier: CGFloat = 0.06
    static let followersButtonTopOffset: CGFloat = 70
    static let followersButtonWidthMultiplier: CGFloat = 0.35
    static let followersButtonHeightMultiplier: CGFloat = 0.06
    static let keyboardAnimationDuration: TimeInterval = 0.3
    static let keyboardHeightDivider: CGFloat = 4
    static let GHFAlertViewTitle = "Something went wrong"
    static let GHFAlertViewButtonTitle = "OK"
    
    //MARK: - FollowersListViewController
    static let collectionViewMinimumLineSpacing: CGFloat = 14
    static let collectionViewMinimumInteritemSpacing: CGFloat = 4
    static let collectViewItemWidthMultiplier: CGFloat = 0.3
    static let collectionViewItemHeightMultiplier: CGFloat = 0.18
    static let collectionViewContentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    static let searchBarPlaceholder: String = "Search for a follower"
    
    //MARK: - FollowersListViewModel
    static let pageNumber = 1
    static let pageLimit = 30
    static let addPage = 1
    static let zero = 0
    static let loadMoreThresholdMultiplier: CGFloat = 1.2
    
    //MARK: - FollowersListCell
    static let followersCellIdentifier = "followersCell"
    static let followersCellImagePlaceholder = "avatar-placeholder"
    static let followersCellImageCornerRadius: CGFloat = 10
    static let followersCellUsernameFont = UIFont.boldSystemFont(ofSize: 18)
    static let followersCellAvatarTopOffset: CGFloat = 8
    static let followersCellAvatarHorizontalInset: CGFloat = 12
    static let followersCellUsernameTopOffset: CGFloat = 14
    static let followersCellUsernameHorizontalInset: CGFloat = 8
    static let followersCellUsernameHeight: CGFloat = 20
    
    //MARK: - UserInfoWebViewController
    static let backButtonTitle = "Back"
    static let backButtonImage = "chevron.left"
    static let backButtonImagePadding: CGFloat = 8
    static let backButtonContentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: -18, bottom: 0, trailing: 0)
    static let backButtonPreferredSymbolConfigurationForImage = UIImage.SymbolConfiguration.init(pointSize: 18, weight: .medium)
    
    //MARK: - Erorr Messages
    static let initialError = "init(coder:) has not been implemented"
    static let invalidURLMessage = "Oops! We couldn't find this GitHub username. Please enter a valid username and try again☺️."
    static let serverErrorMessage = "Oops! We couldn't find this GitHub username. Please check your connection and try again☺️."
    static let invalidResponseMessage = "Oops! We couldn't find this GitHub username. Please verify it and try again☺️."
    static let noFollowersMessage = "Oops! This user currently has no followers. Feel free to be their first!😊."
    static let failedToLoadProfileMessage = "Couldn't load the profile. Please check your connection and try again."
}
