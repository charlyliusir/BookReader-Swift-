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
    let book:Book! = nil
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
        
        loadData()
        
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
    func pageViewControllerSupportedInterfaceOrientations(_ pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        
        return .portrait
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    
    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        return .portrait
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return .min
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
}

extension ContentMainViewController:UIPageViewControllerDataSource
{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 向前
        var aimVC:TextViewController? = nil
        if self.pageViewController.currentPage > 0 {
            self.pageViewController.currentPage -= 1
            aimVC = self.pageViewController.vcList?[self.pageViewController.currentPage]
        }
        
        return aimVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 向后
        var aimVC:TextViewController? = nil
        if self.pageViewController.currentPage < self.pageViewController.totalPage - 1 {
            self.pageViewController.currentPage += 1
            aimVC = self.pageViewController.vcList?[self.pageViewController.currentPage]
        }
        return aimVC
    }
}

