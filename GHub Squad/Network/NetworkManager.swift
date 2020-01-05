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
    
    func getFollowers(for username: String, page: Int, completion: @escaping([Follower]?, String?) -> Void) {
        
        let endpoint  = baseURL + "/users/\(username)/followers?\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username created an invalid request. Please try again")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(nil, "Unable to complete your request. Please check your internet connection")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from the server. Please try again")
                return
            }
            
            guard let data = data else {
                completion(nil, "The data received from the server was invalid. Please try again")
                return
            }
            
            // Parsing the JSON
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                
                completion(followers, nil)
            } catch {
                completion(nil, "The data received from the server was invalid. Please try again")
            }
            
        }
        task.resume()
    }
    
}


// completion handler = Closures
