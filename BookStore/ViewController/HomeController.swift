//
//  ViewController.swift
//  BookStore
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import Fuzi
import Kingfisher
import SVProgressHUD
import DGElasticPullToRefresh

class HomeController: TableViewController,UITableViewDelegate,UITableViewDataSource{
    let Identifier = "Cell"
    var bookList  : Array <Book>! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Initialize tableView
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
        /// 添加FooterView
        let footerView = UIButton(type: .custom)
        footerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 68)
        footerView.setBackgroundImage(Image.init(named: "book_addbook_icon"), for: .normal)
        footerView.addTarget(self, action: #selector(turnBookStore(_:)), for: .touchUpInside)
        tableView.tableFooterView = footerView
        // 加载数据
        self.loadData()
    }
    
    /// tableview delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.bookList[indexPath.row]
        let infoVC   = storyboard?.instantiateViewController(withIdentifier: "MainViewControllerID") as! MainViewController
        infoVC.book  = book
        self.present(infoVC, animated: true, completion: nil)
//        infoVC.book  = book
//        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    /// tableView datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.bookList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let book  = self.bookList[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! BookTableViewCell
        cell.book = book
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 跳转书库
    @IBAction func turnBookStore(_ sender: AnyObject) {
        if sender.isKind(of: UIButton.self) {
            self.navigationController?.pushViewController(CategoryViewController(), animated: true)
        }else{
            self.navigationController?.pushViewController(StoreViewController(), animated: true)
        }
        
    }
    
    /// 加载数据
    func loadData() -> Swift.Void {
        
//        SVProgressHUD.show(withStatus: "正在加载数据")
        NetKit.get(url: BASE_URL, contants: .HTML) { (response) in
            if let data = response.data {
                self.bookList = UnpackData.unpack_book_list(data: data)
                DispatchQueue.main.async(execute: {
//                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                })
            }
        }
        
    }
    
}

