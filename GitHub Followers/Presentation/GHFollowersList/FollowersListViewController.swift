//
//  FollowersListViewController.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 05/02/2025.
//

import UIKit
import RxSwift

/// A view controller that displays a list of followers for a given GitHub username.
class FollowersListViewController: UIViewController {
    
    var username: String?
    private var followers: [Follower] = []
    private let viewModel: FollowersListProtocol = FollowersListViewModel()
    private let disposeBag = DisposeBag()
    
    private var collectionView: UICollectionView?
    private var searchController = UISearchController()
    private var loadingView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureKeyboardBehavior()
        setupBindings()
        viewModel.getFollowers(username: username!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
// MARK: - FollowersList View Setup
    private func setupView(){
        title = username
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setupSearchControllerView()
        setupCollectionView()
        setupLoadingView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = AppConstants.collectionViewMinimumLineSpacing
        layout.minimumInteritemSpacing = AppConstants.collectionViewMinimumInteritemSpacing
        layout.itemSize = CGSize(
            width: view.frame.width * AppConstants.collectViewItemWidthMultiplier,
            height: view.frame.height * AppConstants.collectionViewItemHeightMultiplier
        )
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.contentInset = AppConstants.collectionViewContentInset
        collectionView?.register(FollowersListCell.self, forCellWithReuseIdentifier: FollowersListCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        view.addSubview(collectionView!)
        
        collectionView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupSearchControllerView() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = AppConstants.searchBarPlaceholder
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.setShowsCancelButton(true, animated: true)
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupEmptyStateView(message: String) {
        let emptyStateView = GHFEmptyStateView(message: message)
        view.addSubview(emptyStateView)
        
        emptyStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//MARK: - Setup Binding
    private func setupBindings(){
        viewModel.showLoaderDriver.drive(onNext: { [weak self] isLoading in
            isLoading ? self?.loadingView.startAnimating() : self?.loadingView.stopAnimating()
        }).disposed(by: disposeBag)
        
        viewModel.followersDriver.drive(onNext: { [weak self] result in
            switch result {
            case .success(let followers):
                self?.followers = followers
                self?.collectionView?.reloadData()
            case .failure(let error):
                self?.setupEmptyStateView(message: error.errorMessage)
                self?.navigationItem.searchController = nil
            
            }
        }).disposed(by: disposeBag)
        
        viewModel.filteredfollowersDriver.drive (onNext: { [weak self] followers in
            self?.followers = followers
            self?.collectionView?.reloadData()
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Keyboard Settings
    /// Configures tap gesture to dismiss the keyboard when tapping on the collection view.
    private func configureKeyboardBehavior() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        collectionView?.addGestureRecognizer(tapGesture)
    }
    /// Dismisses the keyboard by resigning the search bar's first responder status.
    @objc private func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}


/// Extension to handle collection view delegate, data source, and search results updating.
extension FollowersListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    
    /// Updates search results based on the search bar input.
    /// - Parameter searchController: The search controller containing the search bar.
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKeyword = searchController.searchBar.text else { return }
        viewModel.getFilteredFollowers(searchKeyword: searchKeyword)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersListCell.identifier, for: indexPath) as? FollowersListCell else {
            return UICollectionViewCell()
        }
        let follower = followers[indexPath.item]
        cell.setFollower(follower: follower)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = followers[indexPath.item]
        let followerInfoVC = UserProfileWebViewController()
        followerInfoVC.user = follower
        navigationController?.pushViewController(followerInfoVC, animated: true)
        searchController.isActive = false
    }
    
    /// Triggers loading more followers when the user scrolls near the bottom.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        viewModel.shouldLoadMoreFollowers(username: username!, offsetY: offsetY, contentHeight: contentHeight, frameHeight: frameHeight)
    }
    
    /// Dismisses the keyboard when scrolling begins.
    /// - Parameter scrollView: The scroll view (collection view) that began dragging.
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}
