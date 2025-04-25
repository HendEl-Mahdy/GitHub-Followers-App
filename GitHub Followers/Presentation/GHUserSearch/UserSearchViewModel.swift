//
//  UserSearchViewModel.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 09/02/2025.
//


import Foundation
import RxSwift
import RxCocoa

/// Protocol defining the interface for managing user search data and UI state.
protocol UserSearchProtocol {
    var userInfoDriver: Driver<Result<String, GHFError>> { get }
    func getUserInfo(username: String)
}

/// View model implementing `UserSearchProtocol` to manage user search data and UI state.
class UserSearchViewModel: UserSearchProtocol {
    
    private let usecase: GHFUseCaseProtocol = GHFUseCase()
    private let disposeBag = DisposeBag()
    
    /// Subject emitting the result of user information fetching.
    private let userInfoSubject = PublishSubject<Result<String, GHFError>>()
    
    /// Driver for emitting user information fetch results.
    var userInfoDriver: Driver<Result<String, GHFError>> {
        return userInfoSubject.asDriver(onErrorJustReturn: .failure(.invalidURL))
    }
    
    /// Fetches user information for the specified username and updates the UI state.
    /// - Parameter username: The GitHub username to fetch information for.
    func getUserInfo(username: String) {
        if username.isEmpty {
            userInfoSubject.onNext(.failure(.invalidURL))
        }else {
            usecase.getUserInfo(username: username)
                .subscribe(onNext: { [weak self] result in
                    switch result {
                    case .success(let user):
                        self?.userInfoSubject.onNext(.success(user.login))
                    case .failure(let error):
                        self?.userInfoSubject.onNext(.failure(error))
                    }
                }).disposed(by: disposeBag)
        }
    }
}
