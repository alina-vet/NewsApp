//
//  HeaderCollectionReusableView.swift
//  NewsApp
//
//  Created by Алина Бондарчук on 02.04.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView, UICollectionViewDelegate {
    
    static let identifier = "HeaderCollectionReusableView"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.sizeToFit()
    }
    
    
    func initDetail(titleName: String, textName: String, timeShamp: Int) {
        titleLabel.text = titleName
        textLabel.text = textName
        dateLabel.text? = timeShamp.timeshampToDateString()
    }
}
