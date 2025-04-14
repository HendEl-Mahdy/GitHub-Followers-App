//
//  NetworkManager.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 08/02/2025.
//

import Foundation
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init (){}
    
    func fetchFollowers(username: String, page: Int) -> Observable<Result<[Follower], GHFError>> {
        
        return Observable.create { observer in
            let stringUrl = "https://api.github.com/users/\(username)/followers?per_page=30&page=\(page)"
            
            guard let url = URL(string: stringUrl) else {
                observer.onNext(.failure(.invalidURL))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    observer.onNext(.failure(.serverError))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    observer.onNext(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    observer.onNext(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let followers = try decoder.decode([Follower].self, from: data)
                    observer.onNext(.success(followers))
                } catch {
                    observer.onNext(.failure(.invalidResponse))
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
    
    func fetchUserInfo(username: String) -> Observable<Result<User, GHFError>> {
        
        return Observable.create { observer in
            let stringUrl = "https://api.github.com/users/\(username)"
            
            guard let url = URL(string: stringUrl) else {
                observer.onNext(.failure(.invalidURL))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    observer.onNext(.failure(.serverError))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    observer.onNext(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    observer.onNext(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let user = try decoder.decode(User.self, from: data)
                    observer.onNext(.success(user))
                } catch {
                    observer.onNext(.failure(.invalidResponse))
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
}
