//
//  NewsTableViewCell.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var additionTimeLabel: UILabel!
    @IBOutlet var viewsCounterLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
