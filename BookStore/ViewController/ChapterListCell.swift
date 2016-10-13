//
//  ChapterListCell.swift
//  BookStore
//
//  Created by 刘朝龙 on 2016/10/13.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class ChapterListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    var nameTitle:String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setStyle() -> Swift.Void {
        nameLabel.text = nameTitle
    }
}
