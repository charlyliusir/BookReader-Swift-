//
//  PageView.swift
//  ScrollPageView
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
/// PageView数据代理
protocol PageViewDataSource {
    @available(iOS 2.0, *)
    func pageView(bookTextInfo pageView: PageView) -> String?
    @available(iOS 2.0, *)
    func pageView(bookName pageView : PageView) -> String?
}
/// PageView的操作代理
protocol PageViewDelegate {
    @available(iOS 2.0, *)
    func pageView(scrollLeftPage pageView: PageView) -> Swift.Void
    @available(iOS 2.0, *)
    func pageView(scrollRightPage pageView: PageView) -> Swift.Void
}
enum ScrollDirection : Int {
    case none, left, right
}

class PageView: UIView {
    var delegate:PageViewDelegate?
    var dataSource:PageViewDataSource?
    var direction:ScrollDirection = .none
    var containerSize:CGSize! // TextView的容器大小
    var scrollView:UIScrollView!
    var layoutManager:NSLayoutManager!
    var textStorage:NSTextStorage!
    
    var vcArrays:Array<PageViewCell>! = []
    var totalCount:Int = 0
    var currCount:Int  = 0
    
    var scrollOriginX:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerSize = CGSize(width: frame.size.width-20, height: frame.size.height-60)
        
        scrollView = UIScrollView(frame: frame)
        scrollView.backgroundColor = rgb(156, 188, 150)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        self.addSubview(scrollView)
        
        textStorage   = NSTextStorage()
        layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
//        let textContainer = NSTextContainer(size: size)
//        layoutManager.addTextContainer(textContainer)
        
        reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 视图加载出来后会调用此方法
    override func draw(_ rect: CGRect) {
        reloadData()
    }
    
    /// 重置ScrollView设置
    func resetScrollView() -> Swift.Void {
        for view in scrollView.subviews
        {
            view.removeFromSuperview()
        }
        scrollView.contentSize = CGSize.zero
    }
    
    /// 计算个数
    func loadUI(withBookText text:String?) -> Swift.Void {
        
        if let bookText = text {
            totalCount = calculateViewCount(withBookText: bookText)
            
            createSubViews(viewCount: totalCount, attributeText: getAttributeString(bookText: bookText))
        }
        
    }
    
    
    /// 刷新数据
    func reloadData() -> Swift.Void {
        // 移除所有视图,并将ScrollView的ContentSize设为一个页面
        resetScrollView()
        // 重新设置视图
        let bookText = dataSource?.pageView(bookTextInfo: self)
        loadUI(withBookText: bookText)
    }
    
    /// 计算视图个数
    func calculateViewCount(withBookText text:String) -> Int {
        let textHeight = getAttributeString(bookText: text).boundingRect(with: containerSize, options: .usesLineFragmentOrigin, context: nil).size.height
        
        let ftotalCount = Int(textHeight) / Int((containerSize?.height)!)
//        if Int(textHeight) % Int((containerSize?.height)!) > 0 {ftotalCount += 1}
        
        var ntotalCount = (ftotalCount*(20)+Int(textHeight))/Int((containerSize?.height)!)
        
        if (ftotalCount*(20)+Int(textHeight))%Int((containerSize?.height)!) > 0 {ntotalCount += 1}
        
        return ntotalCount

    }
    
    /// 创建视图
    func createSubViews(viewCount count:Int, attributeText text:NSAttributedString?) -> Swift.Void {
        
        var temp = 0
        
        while temp < totalCount {
            
            var textContainer:NSTextContainer!
            var pageViewCell:PageViewCell!
            
            if temp >= vcArrays.count {
                textContainer = NSTextContainer(size: containerSize)
                layoutManager.addTextContainer(textContainer)
                pageViewCell  = PageViewCell(frame: CGRect(x: CGFloat(temp) * self.frame.size.width , y: 0, width: self.frame.size.width, height: self.frame.size.height))
                pageViewCell.backgroundColor = rgb(156, 188, 150)
                vcArrays.append(pageViewCell)
            } else {
                textContainer = layoutManager.textContainers[temp]
                pageViewCell  = vcArrays[temp]
            }
            
            pageViewCell.title = text!
            pageViewCell.totalCount = String(totalCount)
            pageViewCell.currCount  = String(temp + 1)
            pageViewCell.name  = self.dataSource?.pageView(bookName: self)
            pageViewCell.textContainer = textContainer
            pageViewCell.setStyle()
            scrollView.addSubview(pageViewCell)
            
            temp += 1
        }
        scrollView.contentSize = CGSize(width: CGFloat(totalCount) * self.frame.size.width, height: self.frame.size.height)
        switch self.direction {
        case .left:
            self.scrollView.contentOffset = CGPoint(x: self.frame.size.width*CGFloat(totalCount-1), y: 0)
            self.direction = .none
        case .right:
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
            self.direction = .none
        default:
            break
        }
    }
    
    /// 获取富文本文字
    func getAttributeString(bookText text:String) -> NSAttributedString {
        let attributeText = NSMutableAttributedString(string: text, attributes: attributes())
        return attributeText
    }
    
    func attributes() -> Dictionary<String,Any> {
        return [NSFontAttributeName:UIFont.systemFont(ofSize: 22), NSParagraphStyleAttributeName:paragraphStyle()]
    }
    
    /// 文本段落设置
    func paragraphStyle() -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        paragraphStyle.firstLineHeadIndent = UIFont.systemFont(ofSize: 22).pointSize * 2
        paragraphStyle.lineBreakMode = .byWordWrapping
        return paragraphStyle
    }
    
}

extension PageView:UIScrollViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// --TODO
        // 判断滑动是否超过前后界限
        
        if self.direction == .left {
            
            self.delegate?.pageView(scrollLeftPage: self)
            
        } else if self.direction == .right {
            
            self.delegate?.pageView(scrollRightPage: self)
            
        } else {
            
            let count = Int(scrollView.contentOffset.x) / Int(self.frame.size.width)
            currCount = count
            
            print("滚动方向 : \(self.currCount)")
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        /// --TODO
        // 判断滑动方向
        if scrollView.contentOffset.x <= -30 && self.direction == .none {
            self.direction = .left
        } else if scrollView.contentOffset.x >= scrollView.contentSize.width - self.frame.size.width + 30 && self.direction == .none {
            self.direction = .right
        } else {
            self.direction = .none
        }
        
    }
    
}
