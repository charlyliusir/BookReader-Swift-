//
//  ContentMainViewController.swift
//  BookStore
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class ContentMainViewController: BaseViewController {
    var pageViewController:BookPageViewController!
    var book:Book! = nil
    let chapterPage:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIApplication.shared.isStatusBarHidden = true
        pageViewController = BookPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options:nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        let titleLabel:UILabel   = UILabel(frame: CGRect.zero)
        let containerView:UIView = UIView(frame: CGRect.zero)
        
        titleLabel.text = "你好"
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(containerView)
        containerView.addSubview(pageViewController.view)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(30)
            make.left.equalTo(self.view).offset(15)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        pageViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        /// 加载章节
//        loadChapter()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

}

// 私有方法
extension ContentMainViewController{
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
                
                pageViewController.setText = text
                
            } else {
                
                NetKit.get(url: temp.address!, contants: .HTML, response: { (response)  in
                    if let data = response.data {
                        UnpackData.unpack_chapter_info(data: data,chapter: &chapter!)
                        self.pageViewController.setText = (chapter?.text!)!
                    }
                })
                
            }
            
        } else {
            print("没有章节")
        }
    }
}

extension ContentMainViewController:UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("will")
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("finish")
    }
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return .none
    }
    
}

extension ContentMainViewController:UIPageViewControllerDataSource
{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 向后
        print("向前。。。")
        var aimVC:BaseViewController? = nil
        self.pageViewController.currentPage += 1
        if self.pageViewController.currentPage < 3 {
            aimVC = self.pageViewController.vcList?[self.pageViewController.currentPage] as! BaseViewController?
        }
        return aimVC
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 向前
        print("向后。。。")
        var aimVC:BaseViewController? = nil
        self.pageViewController.currentPage -= 1
        if self.pageViewController.currentPage > 0 {
            aimVC = self.pageViewController.vcList?[self.pageViewController.currentPage] as! BaseViewController?
        }
        
        return aimVC
    }
}

