//  PersistenceManager.swift
//  GHub Squad
//  Created by George Garcia on 2/18/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static let defaults = UserDefaults.standard
    
    static func retreiveFavorites(completion: @escaping(Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(followers))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    static func updateWith(favoriteFollower: Follower, actionType: PersistenceActionType, completion: @escaping(GFError?) -> Void) {
        retreiveFavorites { (result) in
            
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favoriteFollower) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favoriteFollower)
                    
                    completion(save(favorites: retrievedFavorites))
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favoriteFollower.login}
                }
                
            case .failure(let error):
                completion(error)
            }
        }
    }
}

extension PersistenceManager {
    enum Keys {
        static let favorites = "favorites"
    }
}
