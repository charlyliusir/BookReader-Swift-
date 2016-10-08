//
//  ContentViewController.swift
//  BookStore
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class BookPageViewController: UIPageViewController {
    var size:CGSize!
    var text:String?
    var layoutManager:NSLayoutManager!
    var attribute:NSMutableParagraphStyle = NSMutableParagraphStyle()
    var vcList:Array<TextViewController>?  = []
    let textColor:UIColor! = UIColor.black
    let textFont:UIFont!   = font(20)
    var currentPage = 0
    var totalPage   = 0
    
    
    var setText:String {
        set{
            self.text = newValue
            calculate()
        }
        get{
            return self.text!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.orange
        size = CGSize(width: SCREEN_WIDTH-20, height: self.view.frame.size.height-20)
        
        getAttribute(paragraphStyle: &attribute)
        
        layoutManager = NSLayoutManager()
        let store     = NSTextStorage()
        let container = NSTextContainer()
        store.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(container)
        /// 初始化第一个界面
        let vc        = TextViewController()
        vc.container  = container
        vc.size       = size
        vc.color      = textColor
        vc.font       = textFont
        self.vcList?.append(vc)
        
        self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/// 私有方法
extension BookPageViewController{
    /** 计算本章内容
     *  通过内容计算,以及字体字段等设置,
     */
    func calculate() -> Swift.Void {
        ///
        let textSize = self.text!.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSParagraphStyleAttributeName:self.attribute,NSFontAttributeName:textFont], context: nil).size
        
        totalPage   = Int(textSize.height/size.height)
        currentPage = 0

        var temp = 0
        while temp < currentPage - 1  {
            
            temp = temp + 1
            var container:NSTextContainer!
            var vc:TextViewController!
            layoutManager.addTextContainer(container)
            
            if temp >= (vcList?.count)! {
                vc        = TextViewController()
                container = NSTextContainer(size: size)
                vcList?.append(vc)
            }else{
                vc        = vcList?[temp-1]
                container = layoutManager.textContainers[temp-1]
            }
            
            vc.text       = NSAttributedString(string: self.text!, attributes: [NSParagraphStyleAttributeName:self.attribute])
            vc.container  = container
        }
    }
    
    /// 设置样式
    func getAttribute(paragraphStyle:inout NSMutableParagraphStyle) {
        paragraphStyle.lineSpacing = textFont.capHeight * 2
        paragraphStyle.firstLineHeadIndent = textFont.pointSize * 2
        paragraphStyle.lineBreakMode = .byWordWrapping
    }
    
}
