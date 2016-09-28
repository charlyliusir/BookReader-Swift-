//
//  ViewController.swift
//  BookStore
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import Fuzi

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    let Identifier = "Cell"
    var bookList  : Array <Book>! = []
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier)
        self.view.addSubview(self.tableView)
        
        NetKit.get(url: BASE_URL, contants: .HTML) { (response) in
            if let data = response.data {
                self.bookList = UnpackData.unpack_book_list(data: data)
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    for book in self.bookList
                    {
                        book.class_desc()
                    }
                })
                
            }
        }
    }
    
    /// tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.bookList[indexPath.row]
        let infoVC   = BookInfoViewController()
        infoVC.book  = book
        self.present(infoVC, animated: true, completion: nil)
    }
    
    /// tableView datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.bookList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let book = self.bookList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath)
        
        cell.textLabel?.text = book.name
        cell.detailTextLabel?.text = book.bookDesc
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

