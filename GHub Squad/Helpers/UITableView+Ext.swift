//  UITableView+Ext.swift
//  GHub Squad
//  Created by George Garcia on 2/29/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
}
