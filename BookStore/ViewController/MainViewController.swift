//
//  MainViewController.swift
//  BookStore
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var bookNameLabel: UILabel!
    var pageView: PageView!
    var book:Book!
    
    var currChapter:Int = 0
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.bookNameLabel.text = book.name
        pageView = PageView(frame: self.view.frame)
        pageView.delegate = self
        pageView.dataSource = self
        self.view.addSubview(pageView)
        self.view.bringSubview(toFront: menuView)
        
        loadChapter()
        loadTapGesture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goChapterList(_ sender: AnyObject) {
        let chapterList = ChapterListViewController(nibName: "ChapterListViewController", bundle: Bundle(for: ChapterListViewController.self))
        chapterList.dataRows = book.chapters
        chapterList.titleName = book.name
        chapterList.delegate = self
        let navigation  = UINavigationController(rootViewController: chapterList)
        navigation.navigationBar.tintColor = navigationTintColor
        navigation.navigationBar.barTintColor = navigationBarTintColor
        self.present(navigation, animated: true, completion: nil)
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
        var chapter:Chapter? = book.chapters?[currChapter]
        if let temp = chapter {
            if temp.text != nil {
                pageView.reloadData()
            } else {
                NetKit.get(url: temp.address!, contants: .HTML, response: { (response)  in
                    if let data = response.data {
                        UnpackData.unpack_chapter_info(data: data,chapter: &chapter!)
                        self.pageView.reloadData()
                    }
                })
            }
        } else {
            print("没有章节")
        }
    }
    func loadTapGesture() -> Swift.Void {
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(showMenuUI(_:)))
        self.view.addGestureRecognizer(tapAction)
        
    }
    
    func showMenuUI(_ sender:Any) -> Swift.Void {
        
        menuView.isHidden = !menuView.isHidden
        
    }
    
}

extension MainViewController: ChapterListDelegate {
    func chapterListVC(_ chapterListVC: ChapterListViewController, selectChapter item: Int) {
        currChapter = item
        pageView.reloadData()
        loadChapter()
    }
}

extension MainViewController:PageViewDelegate {
    func pageView(scrollLeftPage _pageView: PageView) {
        
        if currChapter != 0 {
            currChapter -= 1
            pageView.reloadData()
            loadChapter()
        }
        
    }
    
    func pageView(scrollRightPage _pageView: PageView) {
        
        if currChapter != (book.chapters?.count)! - 1 {
            currChapter += 1
            pageView.reloadData()
            loadChapter()
        }
        
    }
    
}

extension MainViewController:PageViewDataSource {
    
    func pageView(bookName pageView: PageView) -> String? {
        return book.chapters?[currChapter].name
    }
    
    func pageView(bookTextInfo pageView: PageView) -> String? {
        return book.chapters?[currChapter].text
    }
    
}
