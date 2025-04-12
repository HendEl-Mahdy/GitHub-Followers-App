//
//  AppConstants.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 04/02/2025.
//

import Foundation
import UIKit

struct AppConstants {
    
    //MARK: - GHFErorr Message
    static let invalidURLMessage = "Oops! We couldn't find this GitHub username. Please enter a valid username and try again☺️."
    static let serverErrorMessage = "Oops! We couldn't find this GitHub username. Please check your connection and try again☺️."
    static let invalidResponseMessage = "Oops! We couldn't find this GitHub username. Please verify it and try again☺️."
    static let noFollowersMessage = "Oops! This user currently has no followers. Feel free to be their first!😊."
    static let failedToLoadProfileMessage = "Couldn't load the profile. Please check your connection and try again."
    
    // GitHubUserSearchVC
    
    
    //MARK: - UserInfoWebViewController
    static let backButtonTitle = "Back"
    static let backButtonImage = "chevron.left"
    static let backButtonImagePadding: CGFloat = 8
    static let backButtonContentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: -18, bottom: 0, trailing: 0)
    static let backButtonPreferredSymbolConfigurationForImage = UIImage.SymbolConfiguration.init(pointSize: 18, weight: .medium)
    
}
