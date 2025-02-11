//
//  GitHubFUseCase.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//


import RxSwift


protocol GitHubFUseCaseProtocol {
    func getFollowers(username: String) -> Observable<Result<[Follower], GHFError>>
    func getUserInfo(username: String) -> Observable<Result<User, GHFError>>
}


class GitHubFUseCase: GitHubFUseCaseProtocol {
    private let githubFRepo = GitHubFRepository()
    
    func getFollowers(username: String) -> Observable<Result<[Follower], GHFError>> {
        return githubFRepo.getFollowers(username: username)
    }
    
    func getUserInfo(username: String) -> Observable<Result<User, GHFError>> {
        return githubFRepo.getUserInfo(username: username)
    }
}
