//
//  PostTableViewCell.swift
//  NewsApp
//
//  Created by Алина Бондарчук on 29.03.2022.
//

import UIKit

protocol PostCellDelegate {
    func moreTapped(cell: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewTextLabel: UILabel!
    @IBOutlet weak var timeShampLabel: UILabel!
    @IBOutlet weak var showTextButton: UIButton!
    
    var delegate: PostCellDelegate?
    var isTapped = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func commonInit(titleName: String, previewTextName: String, timeShamp: Int) {
        isTapped = false
        
        titleLabel.text = titleName
        previewTextLabel.text = previewTextName
        previewTextLabel.numberOfLines = 3
        timeShampLabel.text = timeShamp.timeshampToDateString()
        showTextButton.isHidden = checkNeededReadMoreButton()
    }
    
    @IBAction func showTextAction(_ sender: UIButton) {
        isTapped = !isTapped
        previewTextLabel.numberOfLines = isTapped ? 0 : 3
        showTextButton.setTitle(isTapped ? "Скрыть" : "Подробнее...", for: .normal)
        delegate?.moreTapped(cell: self)
    }
    
    private func checkNeededReadMoreButton() -> Bool{
        return previewTextLabel.maxNumberOfLines <= 3
    }
}
