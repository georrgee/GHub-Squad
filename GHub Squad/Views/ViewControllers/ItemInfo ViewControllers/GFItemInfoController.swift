//  GFItemInfoController.swift
//  GHub Squad
//  Created by George Garcia on 2/11/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

protocol ItemInfoVCDelegate: class {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class GFItemInfoController: UIViewController {
    
    let stackView     = UIStackView()
    let itemInfoView1 = GFItemInfoView()
    let itemInfoView2 = GFItemInfoView()
    let actionButton  = GFButton()
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
    private func configureStackView() {
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoView1)
        stackView.addArrangedSubview(itemInfoView2)
    }
    
    private func configureBackground() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {}
    
    private func layoutUI() {
        view.addSubviews(stackView, actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 50))
        
        actionButton.anchor(top: .none, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding), size: .init(width: 0, height: 44))
        
//        NSLayoutConstraint.activate([
//
//            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
//            stackView.heightAnchor.constraint(equalToConstant: 50)
//
//        ])
    }
}

// Variadic Parameters
