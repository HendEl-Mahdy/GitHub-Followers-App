//
//  GitHubFRepository.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//

import Foundation
import RxSwift

class GitHubFRepository: GitHubFRepositoryProtocol {
    
    func getFollowers(username: String) -> Observable<Result<[Follower], GHFError>> {
        return NetworkManager.shared.fetchFollowers(username: username)
    }
    
    func getUserInfo(username: String) -> Observable<Result<User, GHFError>> {
        return NetworkManager.shared.fetchUserInfo(username: username)
    }
}
