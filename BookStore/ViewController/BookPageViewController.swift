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
    var vcList:Array<Any>?  = []
    let textColor:UIColor! = UIColor.black
    let textFont:UIFont!   = font(22)
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
        size = CGSize(width: SCREEN_WIDTH-20, height: SCREEN_HEIGHT-85)
        
//        getAttribute(paragraphStyle: &attribute)
//        
//        layoutManager = NSLayoutManager()
//        let store     = NSTextStorage()
//        let container = NSTextContainer(size: size)
//        store.addLayoutManager(layoutManager)
//        layoutManager.addTextContainer(container)
//        /// 初始化第一个界面
//        let vc        = TextViewController()
//        vc.container  = container
//        vc.size       = size
//        vc.color      = textColor
//        self.vcList?.append(vc)
        let test1 = Test1ViewController()
        let test2 = Test2ViewController()
        let test3 = Test3ViewController()
        self.vcList?.append(test1)
        self.vcList?.append(test2)
        self.vcList?.append(test3)
        self.setViewControllers([(self.vcList?.first)! as! UIViewController], direction: .reverse, animated: true, completion: nil)
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
        
        totalPage   = Int(textSize.height/size.height) + Int(1)
        currentPage = 0

        var temp = 0
        while temp < totalPage  {
            
            var vc:TextViewController!
            var container:NSTextContainer!
            if temp >= (vcList?.count)! {
                container = NSTextContainer(size: size)
                layoutManager.addTextContainer(container)
                vc            = TextViewController()
                vc.container  = container
                vcList?.append(vc)
            }else{
//                vc        = vcList?[temp]
                container = layoutManager.textContainers[temp]
            }
            
            vc.size       = size
            vc.color      = textColor
            vc.container  = container
            vc.setText    = NSAttributedString(string: self.text!, attributes: [NSParagraphStyleAttributeName:self.attribute, NSFontAttributeName:textFont])
            
            temp = temp + 1
        }
    }
    
    /// 设置样式
    func getAttribute(paragraphStyle:inout NSMutableParagraphStyle) {
        paragraphStyle.lineSpacing = 20
        paragraphStyle.firstLineHeadIndent = textFont.pointSize * 2
        paragraphStyle.lineBreakMode = .byWordWrapping
    }
    
}
