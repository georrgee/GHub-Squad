//  NetworkManager.swift
//  GHub Squad
//  Created by George Garcia on 1/4/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

// This networkmanager is a singleton (global variable kinda...)

// Pros: Convenience
// Cons: One global. It can be mutated, globally. Monolith: giant file that holds everything

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL       = "https://api.github.com/users/"
    let perPage               = "per_page=100"
    let cache                 = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void) {
        
        let endpoint  = baseURL + "\(username)/followers?\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                //completion(nil, .unableToComplete)
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Parsing the JSON
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getUserInfo(for username: String, completion: @escaping(Result<User, GFError>) -> Void) {
        
        let endpoint  = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                //completion(nil, .unableToComplete)
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Parsing the JSON
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in // network call
            
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        task.resume()
    }
    
}

// completion handler = Closures
// NS = Next Step

// CTRL + I = Align function neatly
