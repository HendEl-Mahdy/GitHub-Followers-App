//
//  GHFRepositoryProtocol.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//


import RxSwift


protocol GHFRepositoryProtocol {
    func getFollowers(username: String, page: Int) -> Observable<Result<[Follower], GHFError>>
    func getUserInfo(username: String) -> Observable<Result<User, GHFError>>
}
