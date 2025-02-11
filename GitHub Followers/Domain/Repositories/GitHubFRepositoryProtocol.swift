//
//  GitHubFRepositoryProtocol.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//


import RxSwift


protocol GitHubFRepositoryProtocol {
    func getFollowers(username: String) -> Observable<Result<[Follower], GHFError>>
    func getUserInfo(username: String) -> Observable<Result<User, GHFError>>
}
