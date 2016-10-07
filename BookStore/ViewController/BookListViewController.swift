//
//  BookListViewController.swift
//  BookStore
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh

class BookListViewController: TableViewController,UITableViewDelegate,UITableViewDataSource {
    
    let Identifier = "Cell"
    let titleValue:String! = nil
    var type:BookCategory  = BookCategory.Fantasy_Magic
    var dataSource:Array<Any>! = []
    var page:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = titleValue
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: Identifier)
        
        loadData()
    }
    
    /// tableview delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.dataSource[indexPath.row] as! Book
        let infoVC   = BookInfoViewController()
        infoVC.book  = book
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    /// tableView datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let book  = self.dataSource[indexPath.row] as! Book
        let cell  = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! BookTableViewCell
        cell.book = book
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func refresh() {
        super.refresh()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.page = 1
            self.dataSource.removeAll()
            self.getBookList(page:self.page,handle:{
                self.tableView.es_stopPullToRefresh(completion: true)
            }())
        }
    }
    
    override func loadMore() {
        super.loadMore()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            if self.page < self.dataSource.count  {
                self.getBookList(page:self.page,handle:{
                    self.page += 1
                    self.tableView.es_stopLoadingMore()
                    }())
            } else {
                self.tableView.es_noticeNoMoreData()
            }
        }
    }
    
    func loadData() -> Swift.Void {
        switch type {
        case .Charts, .Other, .Read: break
        default:
            getBookList(page:page,handle: {}())
        }
    }
    
    func getBookList(page:Int, handle:()) -> Swift.Void {
//        SVProgressHUD.show(withStatus: "正在加载数据")
        NetKit.get(url: book_category(category: UInt(self.type.rawValue), page: UInt(page)), contants: .HTML) { (response) in
            if let data = response.data {
                let booklist:Array<Any> = UnpackData.unpack_book_list(data: data)
                if booklist.count > 0 {
                    self.dataSource.append(contentsOf: booklist)
                }
                DispatchQueue.main.async(execute: {
//                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                    handle
                })
            }
        }
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
