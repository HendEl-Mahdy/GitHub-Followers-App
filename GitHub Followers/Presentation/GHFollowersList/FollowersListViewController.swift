//
//  FollowersListViewController.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 05/02/2025.
//

import UIKit
import RxSwift

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
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: view.frame.width * 0.3, height: view.frame.height * 0.18)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
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
        searchController.searchBar.placeholder = "Search for a follower"
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
    private func configureKeyboardBehavior() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        collectionView?.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}

extension FollowersListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        viewModel.shouldLoadMoreFollowers(username: username!, offsetY: offsetY, contentHeight: contentHeight, frameHeight: frameHeight)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}
