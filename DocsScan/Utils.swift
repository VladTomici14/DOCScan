//
//  Utils.swift
//  DocsScan
//
//  Created by Vlad Tomici on 27.03.2024.
//

import Foundation

final class Utils {
    
    func formatDate(date: Date) -> String {
        let stringDate: String = fromDateToString(date: date)
        
        // TODO: add all the formatting that you want to do
        
        return stringDate
    }
    
    
    func fromDateToString(date: Date) -> String {
        /**
         Transforming a variable from Date type to String type.
         
            @param date: date that will be changed to a string
            @return: a string that contains the formated date in the
         */
        return date.formatted()
    }
}
