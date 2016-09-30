//
//  CategoryCollectionViewCell.swift
//  BookStore
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    var bgImageView:UIImageView!
    var titleLabel:UILabel!
    
    var cellTitle:String!
    var title:String {
        set{
            self.cellTitle = newValue
            titleLabel.text = newValue
        }
        get{
            return self.cellTitle
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgImageView = UIImageView(image: UIImage.init(named: "book_cell_icon"))
        titleLabel  = UILabel(frame: CGRect.zero)
        titleLabel.text = "分类"
        titleLabel.font = subtitleFont
        titleLabel.textColor = textColor
        
        self.contentView.addSubview(bgImageView)
        self.bgImageView.addSubview(titleLabel)
        
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(bgImageView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
