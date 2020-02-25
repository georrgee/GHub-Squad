//  GFDataLoadingController.swift
//  GHub Squad
//  Created by George Garcia on 2/24/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class GFDataLoadingController: UIViewController {
    
    var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds) // fill the whole screen
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
