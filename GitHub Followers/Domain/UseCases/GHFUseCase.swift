//
//  GHFUseCase.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//


import RxSwift


protocol GHFUseCaseProtocol {
    func getFollowers(username: String, page: Int) -> Observable<Result<[Follower], GHFError>>
    func getUserInfo(username: String) -> Observable<Result<User, GHFError>>
}


class GHFUseCase: GHFUseCaseProtocol {
    private let githubFRepo = GHFRepository()
    
    func getFollowers(username: String, page: Int) -> Observable<Result<[Follower], GHFError>> {
        return githubFRepo.getFollowers(username: username, page: page)
    }
    
    func getUserInfo(username: String) -> Observable<Result<User, GHFError>> {
        return githubFRepo.getUserInfo(username: username)
    }
}
