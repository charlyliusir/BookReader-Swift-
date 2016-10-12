//
//  PageViewCell.swift
//  ScrollPageView
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import SnapKit

class PageViewCell: NibDesignable {
    var textView:UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    /// 数据
    open var name:String?
    open var totalCount:String?
    open var currCount:String?
    open var title:NSAttributedString!
    open var textContainer:NSTextContainer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setStyle() {
        if textView == nil {
            textView  = UITextView(frame: CGRect(x: 10, y: 0, width: self.frame.size.width-20, height: self.frame.size.height-60), textContainer: self.textContainer)
            textView.isEditable = false
            textView.isScrollEnabled = false
            self.contentView.addSubview(textView)
            self.sendSubview(toBack: self.textView)
        }
        
        self.textView.attributedText = title
        self.titleLabel.text = name
        self.totalLabel.text = totalCount
        self.currentLabel.text = currCount
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
