//  Date+Ext.swift
//  GHub Squad
//  Created by George Garcia on 2/17/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
