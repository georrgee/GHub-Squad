//  GFError.swift
//  GHub Squad
//  Created by George Garcia on 1/4/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import Foundation

enum GFError: String, Error {
    case invalidUsername  = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse  = "Invalid response from the server. Please try again"
    case invalidData      = "The data received from the server was invalid. Please try again"
}

// changed comment title from ErrorMessage to GFError
