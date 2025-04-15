//
//  GHFRepository.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//

import Foundation
import RxSwift

class GHFRepository: GHFRepositoryProtocol {
    
    func getFollowers(username: String, page: Int) -> Observable<Result<[Follower], GHFError>> {
        return NetworkManager.shared.fetchFollowers(username: username, page: page)
    }
    
    func getUserInfo(username: String) -> Observable<Result<User, GHFError>> {
        return NetworkManager.shared.fetchUserInfo(username: username)
    }
}
