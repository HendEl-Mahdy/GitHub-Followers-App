//
//  UserSearchViewModel.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 09/02/2025.
//


import Foundation
import RxSwift
import RxCocoa

protocol UserSearchProtocol {
    var userInfoDriver: Driver<Result<String, GHFError>> { get }
    func getUserInfo(username: String)
}

class UserSearchViewModel: UserSearchProtocol {
    
    private let usecase: GHFUseCaseProtocol = GHFUseCase()
    private let userInfoSubject = PublishSubject<Result<String, GHFError>>()
    private let disposeBag = DisposeBag()
    
    var userInfoDriver: Driver<Result<String, GHFError>> {
        return userInfoSubject.asDriver(onErrorJustReturn: .failure(.invalidURL))
    }
    
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
