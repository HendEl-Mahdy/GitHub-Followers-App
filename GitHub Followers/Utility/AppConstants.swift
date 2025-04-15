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
