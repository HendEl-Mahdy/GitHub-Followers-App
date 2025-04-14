//
//  FollowersListViewModel.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 10/02/2025.
//

import Foundation
import RxSwift
import RxCocoa

protocol FollowersListProtocol {
    var followersDriver: Driver<Result<[Follower], GHFError>> {get}
    var filteredfollowersDriver: Driver<[Follower]> {get}
    var showLoaderDriver: Driver<Bool> {get}
    func getFollowers(username: String)
    func getFilteredFollowers(searchKeyword: String)
    func shouldLoadMoreFollowers(username: String, offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat)
}

class FollowersListViewModel: FollowersListProtocol {
    
    private var usecase: GitHubFUseCaseProtocol = GitHubFUseCase()
    private var followersSubject = PublishSubject<Result<[Follower], GHFError>>()
    private var filteredfollowersSubject = PublishSubject<[Follower]>()
    private var showLoaderSubject = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    private var followers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    private var hasMoreFollower = true
    private var page = 1
    
    var followersDriver: Driver<Result<[Follower], GHFError>> {
        return followersSubject.asDriver(onErrorJustReturn: .failure(.invalidURL))
    }
    
    var filteredfollowersDriver: Driver<[Follower]> {
        return filteredfollowersSubject.asDriver(onErrorJustReturn: followers)
    }
    
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
                    if followers.count == 0 {
                        self.followersSubject.onNext(.failure(.noFollowes))
                    }else if followers.count < 30 {
                        self.followers.append(contentsOf: followers)
                        self.hasMoreFollower = false
                        self.followersSubject.onNext(.success(self.followers))
                    }else {
                        self.followers.append(contentsOf: followers)
                        self.page += 1
                        self.followersSubject.onNext(.success(self.followers))
                    }
                    self.showLoaderSubject.onNext(false)
                case .failure(let error):
                    self.followersSubject.onNext(.failure(error))
                    self.showLoaderSubject.onNext(false)
                }
            }).disposed(by: disposeBag)
    }
    
    func getFilteredFollowers(searchKeyword: String) {
        if !searchKeyword.isEmpty {
            filteredFollowers = followers.filter { $0.login.lowercased().contains(searchKeyword.lowercased())}
            filteredfollowersSubject.onNext(filteredFollowers)
        }else {
            filteredfollowersSubject.onNext(followers)
        }
    }
    
    func shouldLoadMoreFollowers(username: String, offsetY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat) {
        if offsetY > contentHeight - frameHeight * 1.2, hasMoreFollower {
            getFollowers(username: username)
        }
    }
}
