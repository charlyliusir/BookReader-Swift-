//
//  BookInfoViewController.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class BookInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let Identifiter = "Cell"
    var book:Book!
    var chapterList:Array<Chapter>! = []
    var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title     = book.name
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifiter)
        self.view.addSubview(self.tableView)
        
        NetKit.get(url: book.address!, contants: .HTML) { (response) in
            if let data = response.data {
                self.book.chapters = UnpackData.unpack_chapter_list(data: data, book: self.book)
                DispatchQueue.main.async(execute: {
                    self.chapterList = self.book.chapters
                    self.tableView.reloadData()
                })
            }
        }
        
    }
    /// tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapter = self.chapterList[indexPath.row]
        let textVC   = TextViewController()
        textVC.book  = book!
        textVC.chapter = chapter
        self.present(textVC, animated: true, completion: nil)
    }
    
    /// tableView datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.chapterList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let chapter = self.chapterList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiter, for: indexPath)
        
        cell.textLabel?.text = chapter.name
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
