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
    private var loadingView = GHFLoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        viewModel.getFollowers(username: username!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupView(){
        title = username
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectionView()
        setupLoadingView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: view.frame.width * 0.3, height: view.frame.height * 0.2)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(FollowersListCell.self, forCellWithReuseIdentifier: FollowersListCell.identifier)
        
        view.addSubview(collectionView!)
        
        collectionView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupEmptyStateView(message: String) {
        let emptyStateView = GHFEmptyStateView(message: message)
        view.addSubview(emptyStateView)
        
        emptyStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings(){
        viewModel.showLoaderDriver.drive(onNext: { [weak self] isLoading in
            isLoading ? self?.loadingView.showLoading() : self?.loadingView.hideLoading()
        }).disposed(by: disposeBag)
        
        viewModel.followersDriver.drive(onNext: { [weak self] result in
            switch result {
            case .success(let followers):
                self?.followers.append(contentsOf: followers)
                self?.collectionView?.reloadData()
            case .failure(let error):
                self?.setupEmptyStateView(message: error.errorMessage)
            }
        }).disposed(by: disposeBag)
    }
}

extension FollowersListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        let followerInfoVC = FollowerInfoViewController()
        followerInfoVC.followerName = follower.login
        navigationController?.pushViewController(followerInfoVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        viewModel.shouldLoadMoreFollowers(username: username!, offsetY: offsetY, contentHeight: contentHeight, height: height)
    }
}
