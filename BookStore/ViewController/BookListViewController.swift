//
//  BookListViewController.swift
//  BookStore
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import SVProgressHUD

class BookListViewController: TableViewController,UITableViewDelegate,UITableViewDataSource {
    
    let Identifier = "Cell"
    let titleValue:String! = nil
    var type:BookCategory  = BookCategory.Fantasy_Magic
    var dataSource:Array<Any>! = []
    var page:UInt! = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = titleValue
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: Identifier)
        
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            // Do not forget to call dg_stopLoading() at the end
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor((self.navigationController?.navigationBar.barTintColor)!)
        tableView.dg_setPullToRefreshBackgroundColor(backgroundColor)
        
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
    
    func loadData() -> Swift.Void {
        switch type {
        case .Charts, .Other, .Read: break
        default:
            getBookList(page:page)
        }
    }
    
    func getBookList(page:UInt) -> Swift.Void {
        SVProgressHUD.show(withStatus: "正在加载数据")
        NetKit.get(url: book_category(category: UInt(self.type.rawValue), page: page), contants: .HTML) { (response) in
            if let data = response.data {
                let booklist = UnpackData.unpack_book_list(data: data)
                if booklist.count > 0 {
                    self.dataSource.append(booklist)
//                    page = page + 1
                }
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
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
