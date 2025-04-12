//
//  UserProfileWebViewController.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 10/04/2025.
//

import UIKit
import WebKit
import SnapKit

/// Displays a user's GitHub profile in a web view using their `htmlUrl` from a `Follower` object.
/// Shows an empty state custom view for invalid URL.
class UserProfileWebViewController: UIViewController {
    
    // MARK: - Properties
    var user: Follower?
    private var profileWebView = WKWebView()
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    /// Configuration for the back button with title, icon, and styling.
    private lazy var backButtonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        config.title = AppConstants.backButtonTitle
        config.image = UIImage(systemName: AppConstants.backButtonImage)
        config.imagePadding = AppConstants.backButtonImagePadding
        config.preferredSymbolConfigurationForImage = AppConstants.backButtonPreferredSymbolConfigurationForImage
        config.contentInsets = AppConstants.backButtonContentInsets
        return config
    }()
    
    private lazy var backButton = UIButton(
        configuration: backButtonConfig,
        primaryAction: UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupView()
        openUserProfileView()
    }
    
    // MARK: - Setup Methods
    private func setupNavigationView() {
        title = user?.login
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupView() {
        profileWebView.navigationDelegate = self
        view.addSubview(profileWebView)
        view.addSubview(activityIndicatorView)
        
        profileWebView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    /// Loads the user's GitHub profile URL in the web view or shows an empty state custom view if invalid.
    private func openUserProfileView() {
        guard let user = user,
              let websiteURL = URL(string: user.htmlUrl),
              let host = websiteURL.host(percentEncoded: false), !host.isEmpty else {
            showEmptyStateView(error: GHFError.failedToLoadProfile)
            return
        }
        profileWebView.load(URLRequest(url: websiteURL))
    }
    
    /// Shows an empty state custom view and  hides the web view.
    /// - Parameter error: The `GHFError` containing the message to display.
    private func showEmptyStateView(error: GHFError) {
        let emptyStateView = GHFEmptyStateView(message: error.errorMessage)
        view.addSubview(emptyStateView)
        view.bringSubviewToFront(emptyStateView)
        
        emptyStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        profileWebView.isHidden = true
    }
}

// MARK: - WKNavigationDelegate

extension UserProfileWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        activityIndicatorView.stopAnimating()
        showEmptyStateView(error: GHFError.failedToLoadProfile)
    }
}
