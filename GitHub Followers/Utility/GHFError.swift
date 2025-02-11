//
//  GHFError.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//

import Foundation

enum GHFError: String, Error {
    case invalidURL
    case serverError
    case invalidResponse
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return AppConstants.invalidURLMessage
        case .serverError:
            return AppConstants.serverErrorMessage
        case .invalidResponse:
            return AppConstants.invalidResponseMessage
        }
    }
}
