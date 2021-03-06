//  GFAlertVC.swift
//  GHub Squad
//  Created by George Garcia on 1/3/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView    = GFAlertContainerView()
    let titleLabel       = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageBodyLabel = GFBodyLabel(textAlignment: .center)
    let actionButton     = GFButton(backgroundColor: .systemPink, title: "Okay!")
    
    var alertTitle:  String?
    var message:     String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle  = title
        self.message     = message
        self.buttonTitle = buttonTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        view.addSubviews(containerView, titleLabel, actionButton, messageBodyLabel)
        setupEntireLayout()
    }
    
    func setupEntireLayout() {
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    func configureContainerView() {
        containerView.anchor(top: .none, leading: .none, bottom: .none, trailing: .none, size: .init(width: 280, height: 250))
        containerView.centerInSuperview()
    }
    
    func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong" // ?? = nil colecing: use alerttile, if it is nil, give it a default value
        
        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: .none, trailing: containerView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 28))
    }
    
    func configureActionButton() {
        actionButton.setTitle(buttonTitle ?? "Okay", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        actionButton.anchor(top: .none, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding), size: .init(width: 0, height: 44))
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureBodyLabel() {        
        messageBodyLabel.text          = message ?? "Unable to complete request"
        messageBodyLabel.numberOfLines = 4
        
        messageBodyLabel.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: actionButton.topAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 8, left: padding, bottom: 12, right: padding))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// order of constraints matter
