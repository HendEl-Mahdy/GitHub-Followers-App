//
//  User.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    let name: String?
    let location: String?
    let company: String?
    let bio: String?
    let publicRepos: Int
    let followers: Int
    let following: Int
    let htmlUrl: String
    let reposUrl: String
    let createdAt: String
}
