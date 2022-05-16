//
//  Int.swift
//  NewsApp
//
//  Created by Алина Бондарчук on 13.05.2022.
//

import Foundation
import UIKit

extension Int {
    func timeshampToDateString() -> String {
        let date = Date(timeIntervalSince1970: Double(self))
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd.MMM.yyyy")
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
