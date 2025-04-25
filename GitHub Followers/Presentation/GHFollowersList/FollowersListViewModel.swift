//
//  FollowersListViewModel.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 10/02/2025.
//

import Foundation
import RxSwift
import RxCocoa

/// Protocol defining the interface for managing follower data and UI state.
protocol FollowersListProtocol {
    var followersDriver: Driver<Result<[Follower], GHFError>> {get}
    var filteredfollowersDriver: Driver<[Follower]> {get}
    var showLoaderDriver: Driver<Bool> {get}
    func getFollowers(username: String)
    func getFilteredFollowers(searchKeyword: String)
    func shouldLoadMoreFollowers(username: String, offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
}

/// View model implementing `FollowersListProtocol` to manage follower data and UI state.
class FollowersListViewModel: FollowersListProtocol {
    private var followers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    private var followersSubject = PublishSubject<Result<[Follower], GHFError>>()
    private var filteredfollowersSubject = PublishSubject<[Follower]>()
    private var showLoaderSubject = PublishSubject<Bool>()
    private var usecase: GHFUseCaseProtocol = GHFUseCase()
    private let disposeBag = DisposeBag()
    
    /// Indicates whether more followers are available for pagination.
    private var hasMoreFollower = true
    /// The current page number for pagination.
    private var page = AppConstants.pageNumber
    
    /// Driver for emitting follower fetch results.
    var followersDriver: Driver<Result<[Follower], GHFError>> {
        return followersSubject.asDriver(onErrorJustReturn: .failure(.invalidURL))
    }
    
    /// Driver for emitting filtered followers.
    var filteredfollowersDriver: Driver<[Follower]> {
        return filteredfollowersSubject.asDriver(onErrorJustReturn: followers)
    }
    
    /// Driver for emitting the loading state.
    var showLoaderDriver: Driver<Bool> {
        return showLoaderSubject.asDriver(onErrorJustReturn: false)
    }
    
    func getFollowers(username: String) {
        showLoaderSubject.onNext(true)
        usecase.getFollowers(username: username, page: page)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let followers):
                    if followers.count == AppConstants.zero {
                        self.followersSubject.onNext(.failure(.noFollowes))
                    }else if followers.count < AppConstants.pageLimit {
                        self.followers.append(contentsOf: followers)
                        self.hasMoreFollower = false
                        self.followersSubject.onNext(.success(self.followers))
                    }else {
                        self.followers.append(contentsOf: followers)
                        self.page += AppConstants.addPage
                        self.followersSubject.onNext(.success(self.followers))
                    }
                    self.showLoaderSubject.onNext(false)
                case .failure(let error):
                    self.followersSubject.onNext(.failure(error))
                    self.showLoaderSubject.onNext(false)
                }
            }).disposed(by: disposeBag)
    }
    
    /// Filters the followers list based on the search keyword and updates the UI.
    /// - Parameter searchKeyword: The keyword to filter followers by.
    func getFilteredFollowers(searchKeyword: String) {
        if !searchKeyword.isEmpty {
            filteredFollowers = followers.filter { $0.login.lowercased().contains(searchKeyword.lowercased())}
            filteredfollowersSubject.onNext(filteredFollowers)
        }else {
            filteredfollowersSubject.onNext(followers)
        }
    }
    
    /// Checks if more followers should be loaded based on the scroll position.
    /// - Parameters:
    ///   - username: The GitHub username to fetch more followers for.
    ///   - offsetY: The current vertical scroll offset.
    ///   - contentHeight: The total height of the scrollable content.
    ///   - frameHeight: The height of the scroll view's frame.
    func shouldLoadMoreFollowers(username: String, offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat) {
        if offsetY > contentHeight - frameHeight * AppConstants.loadMoreThresholdMultiplier, hasMoreFollower {
            getFollowers(username: username)
        }
    }
}
