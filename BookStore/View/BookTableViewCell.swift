//
//  BookTableViewCell.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    var bimage: UIImageView?
    var bname : UILabel?
    var bauthor:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
