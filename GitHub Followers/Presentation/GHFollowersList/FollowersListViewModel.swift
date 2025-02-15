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
    var showLoaderDriver: Driver<Bool> {get}
    func getFollowers(username: String)
    func shouldLoadMoreFollowers(username: String, offsetY: CGFloat, contentHeight: CGFloat, height: CGFloat)
}

class FollowersListViewModel: FollowersListProtocol {
    
    private var usecase: GitHubFUseCaseProtocol = GitHubFUseCase()
    private var followersPublishSubject = PublishSubject<Result<[Follower], GHFError>>()
    private var showLoaderSubject = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    private var page = 1
    private var hasMoreFollower = true
    
    var followersDriver: RxCocoa.Driver<Result<[Follower], GHFError>> {
        return followersPublishSubject.asDriver(onErrorJustReturn: .failure(.invalidURL))
    }
    
    var showLoaderDriver: Driver<Bool> {
        return showLoaderSubject.asDriver(onErrorJustReturn: false)
    }

    
    func getFollowers(username: String) {
        showLoaderSubject.onNext(true)
        usecase.getFollowers(username: username, page: page)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let followers):
                    if followers.count == 0 {
                        self?.followersPublishSubject.onNext(.failure(.noFollowes))
                    }else if followers.count < 100 {
                        self?.hasMoreFollower = false
                        self?.followersPublishSubject.onNext(.success(followers))
                    }else {
                        self?.page += 1
                        self?.followersPublishSubject.onNext(.success(followers))
                    }
                    self?.showLoaderSubject.onNext(false)
                case .failure(let error):
                    self?.followersPublishSubject.onNext(.failure(error))
                    self?.showLoaderSubject.onNext(false)
                }
            }).disposed(by: disposeBag)
    }
    
    func shouldLoadMoreFollowers(username: String, offsetY: CGFloat, contentHeight: CGFloat, height: CGFloat) {
        if offsetY > contentHeight - height, hasMoreFollower {
            getFollowers(username: username)
        }
    }
}
