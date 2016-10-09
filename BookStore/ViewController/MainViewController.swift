//
//  MainViewController.swift
//  BookStore
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var pageLabel: UILabel!
    var book:Book!
    var pageController:UIPageViewController!
    var controllers:Array<BookViewController>! = []
    var currentPage:Int = 0
    var chapterPage:Int = 0
    
    var size:CGSize!
    var text:String?
    var layoutManager:NSLayoutManager!
    var attribute:NSMutableParagraphStyle = NSMutableParagraphStyle()
    let textColor:UIColor! = UIColor.black
    let textFont:UIFont!   = font(22)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        size = CGSize(width: SCREEN_WIDTH-20, height: SCREEN_HEIGHT-40)
        pageController = self.childViewControllers.first as! UIPageViewController
        
        getAttribute(paragraphStyle: &attribute)
        
        layoutManager = NSLayoutManager()
        let store     = NSTextStorage()
        let container = NSTextContainer(size: size)
        store.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(container)
        /// 初始化第一个界面
        let vc        = storyboard?.instantiateViewController(withIdentifier: "BookController") as! BookViewController
        vc.container  = container
        vc.size       = size
        vc.color      = textColor
        self.controllers?.append(vc)
        
        pageController.dataSource = self
        
        pageController.setViewControllers([controllers.first!], direction: .forward, animated: true, completion: nil)
        
        loadChapter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// 私有方法
extension MainViewController{
    /// 加载目录
    func loadChapter() {
        NetKit.get(url: book.address!, contants: .HTML, response: { (response)  in
            if let data = response.data {
                self.book.chapters = UnpackData.unpack_chapter_list(data: data, book: self.book)
                DispatchQueue.main.async(execute: {
                    self.loadData()
                })
            }
        })
    }
    /// 加载章节数据
    func loadData() {
        var chapter:Chapter? = book.chapters?[chapterPage]
        if let temp = chapter {
            
            if let text = temp.text {
                
                self.calculateText(text:text)
                
            } else {
                
                NetKit.get(url: temp.address!, contants: .HTML, response: { (response)  in
                    if let data = response.data {
                        UnpackData.unpack_chapter_info(data: data,chapter: &chapter!)
                        self.calculateText(text: (chapter?.text!)!)
                    }
                })
                
            }
            
        } else {
            print("没有章节")
        }
    }
    
    func calculateText(text:String) {
        ///
        currentPage = 0
        let textSize = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSParagraphStyleAttributeName:self.attribute,NSFontAttributeName:textFont], context: nil).size
        var temp = 0
        let totalPage   = Int(textSize.height/size.height) + Int(2)
        while temp < totalPage  {
            var vc:BookViewController!
            var container:NSTextContainer!
            if temp >= (controllers?.count)! {
                container = NSTextContainer(size: size)
                layoutManager.addTextContainer(container)
                vc            = storyboard?.instantiateViewController(withIdentifier: "BookController") as! BookViewController
                vc.container  = container
                controllers?.append(vc)
            }else{
                vc        = controllers?[temp]
                container = layoutManager.textContainers[temp]
            }
            
            vc.size       = size
            vc.color      = textColor
            vc.container  = container
            vc.setText    = NSAttributedString(string: text, attributes: [NSParagraphStyleAttributeName:self.attribute, NSFontAttributeName:textFont])
            
            temp = temp + 1
        }
        
        updatePage()
    }
    
    /// 设置样式
    func getAttribute(paragraphStyle:inout NSMutableParagraphStyle) {
        paragraphStyle.lineSpacing = 20
        paragraphStyle.firstLineHeadIndent = textFont.pointSize * 2
        paragraphStyle.lineBreakMode = .byWordWrapping
    }
    
    /// 更新页面信息
    func updatePage() {
        self.pageLabel.text = "第 " + String(currentPage+1) + " / " + String(controllers.count) + " 页"
    }
}


extension MainViewController: UIPageViewControllerDataSource {
    
    //返回当前页面的下一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("向前")
        let bookController = viewController as! BookViewController
        currentPage = controllers.index(of:bookController)!
        updatePage()
        if currentPage != controllers.count - 1 {
            return controllers[currentPage+1]
        } else {
            return nil
        }
        
    }
    
    //返回当前页面的上一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("向后")
        let bookController = viewController as! BookViewController
        currentPage = controllers.index(of:bookController)!
        updatePage()
        if currentPage != 0 {
            return controllers[currentPage-1]
        } else {
            return nil
        }
        
    }
}
