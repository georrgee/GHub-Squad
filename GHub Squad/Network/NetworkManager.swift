//  NetworkManager.swift
//  GHub Squad
//  Created by George Garcia on 1/4/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

// This networkmanager is a singleton (global variable kinda...)

// Pros: Convenience
// Cons: One global. It can be mutated, globally. Monolith: giant file that holds everything

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL       = "https://api.github.com/users/"
    let perPage       = "per_page=100"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping([Follower]?, ErrorMessage?) -> Void) {
        
        let endpoint  = baseURL + "\(username)/followers?\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(nil, .unableToComplete)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            // Parsing the JSON
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                
                completion(followers, nil)
            } catch {
                completion(nil, .invalidData)
            }
            
        }
        task.resume()
    }
    
}

// completion handler = Closures
