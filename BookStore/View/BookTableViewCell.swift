//
//  BookTableViewCell.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import SnapKit
/// cell 高度 85
class BookTableViewCell: UITableViewCell {
    var icon : UIImageView! /// width 52 height 65
    var line : UIImageView!
    var name : UILabel!     /// size 18 color hsb(285,0,29)
    var author  : UILabel!  /// size 14 color hsb(285,0,61)
    var chapter : UILabel!  /// size 14 color hsb(285,0,61)
    var cellBook:Book?
    var book:Book? {
        set{
            self.cellBook = newValue
            name.text = newValue?.name
            author.text  = newValue?.author?.name
            if let cname = newValue?.newschapter?.name {
                chapter.text = "最新章节：" + cname
            }
            if let img = newValue?.imgAddres {
                icon.kf.setImage(with: URL(string:img))
            }
            
        }
        get{
            return self.book
        }
    }
    
    func setCellBook(book:Book) {
        
        print("set cell book")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        icon = UIImageView(image: UIImage.init(named: "book_placeholder_image"))
        line = UIImageView(image: UIImage.init(named: "cell_line"))
        
        let container:UIView = UIView(frame: CGRect.zero)
        
        name = UILabel(frame: CGRect.zero)
        author  = UILabel(frame: CGRect.zero)
        chapter = UILabel(frame: CGRect.zero)
        
        name.font = subtitleFont
        author.font  = smallFont
        chapter.font = smallFont
        
        name.textColor = blackColor
        author.textColor  = grayColor
        chapter.textColor = grayColor
        
        name.text    = "书名"
        author.text  = "作者"
        chapter.text = "最新章节："
        author.textAlignment  = .left
        chapter.textAlignment = .left
        
        self.addSubview(icon)
        self.addSubview(line)
        self.addSubview(container)
        container.addSubview(name)
        container.addSubview(author)
        container.addSubview(chapter)
        
        icon.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(52)
            make.height.equalTo(65)
        })
        
        line.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(13)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        })
        
        container.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon)
            make.left.equalTo(icon.snp.right).offset(20)
            make.right.equalTo(chapter)
            make.bottom.equalTo(chapter)
        }
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(container)
            make.left.equalTo(container)
        }
        
        author.snp.makeConstraints { (make) in
            make.left.equalTo(name.snp.right).offset(10)
            make.bottom.equalTo(name)
            make.width.equalTo(100)
        }
        
        chapter.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(10)
            make.left.equalTo(name)
            make.right.equalTo(self).offset(-10)
        }
        
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
