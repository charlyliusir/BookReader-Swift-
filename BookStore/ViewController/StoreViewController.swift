//
//  StoreViewController.swift
//  BookStore
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

enum StoreType:Int {
    case search = 1, category, charts, read
    
    func simpleDescription() -> String {
        switch self {
        case .search:
            return "搜索"
        case .category:
            return "分类"
        case .charts:
            return "排行榜"
        case .read:
            return "最近阅读"
        }
        
    }
}

class StoreViewController: BaseViewController {

    func initUI() -> Swift.Void {
        /// 搜索
        let searchBtn = UIButton(type: .custom)
        searchBtn.setBackgroundImage(UIImage.init(named: "book_cell_icon"), for: .normal)
        searchBtn.setTitle(StoreType.search.simpleDescription(), for: .normal)
        searchBtn.setTitleColor(textColor, for: .normal)
        searchBtn.titleLabel?.font = subtitleFont
        searchBtn.tag = StoreType.search.rawValue
        searchBtn.addTarget(self, action: #selector(turnNextVC(_:)), for: .touchUpInside)
        /// 分类
        let cateBtn = UIButton(type: .custom)
        cateBtn.setBackgroundImage(UIImage.init(named: "book_cell_icon"), for: .normal)
        cateBtn.setTitle(StoreType.category.simpleDescription(), for: .normal)
        cateBtn.setTitleColor(textColor, for: .normal)
        cateBtn.titleLabel?.font = subtitleFont
        cateBtn.tag = StoreType.category.rawValue
        cateBtn.addTarget(self, action: #selector(turnNextVC(_:)), for: .touchUpInside)
        /// 排行
        let chartsBtn = UIButton(type: .custom)
        chartsBtn.setBackgroundImage(UIImage.init(named: "book_cell_icon"), for: .normal)
        chartsBtn.setTitle(StoreType.charts.simpleDescription(), for: .normal)
        chartsBtn.setTitleColor(textColor, for: .normal)
        chartsBtn.titleLabel?.font = subtitleFont
        chartsBtn.tag = StoreType.charts.rawValue
        chartsBtn.addTarget(self, action: #selector(turnNextVC(_:)), for: .touchUpInside)
        /// 最近阅读
        let readBtn = UIButton(type: .custom)
        readBtn.setBackgroundImage(UIImage.init(named: "book_cell_icon"), for: .normal)
        readBtn.setTitle(StoreType.read.simpleDescription(), for: .normal)
        readBtn.setTitleColor(textColor, for: .normal)
        readBtn.titleLabel?.font = subtitleFont
        readBtn.tag = StoreType.read.rawValue
        readBtn.addTarget(self, action: #selector(turnNextVC(_:)), for: .touchUpInside)
        
        self.view.addSubview(searchBtn)
        self.view.addSubview(cateBtn)
        self.view.addSubview(chartsBtn)
        self.view.addSubview(readBtn)
        
        searchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(51+64)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
        cateBtn.snp.makeConstraints { (make) in
            make.top.equalTo(searchBtn.snp.bottom).offset(30)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
//            make.edges.equalToSuperview()
        }
        
        chartsBtn.snp.makeConstraints { (make) in
            make.top.equalTo(cateBtn.snp.bottom).offset(30)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
        readBtn.snp.makeConstraints { (make) in
            make.top.equalTo(chartsBtn.snp.bottom).offset(30)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "书库"
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func turnNextVC(_ sender:AnyObject) -> Swift.Void {
        let btn = sender as! UIButton
        var vc:BaseViewController!
        switch btn.tag {
        case 1:
            vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewControllerID") as! SearchViewController
        case 2:
            vc = storyboard?.instantiateViewController(withIdentifier: "CategoryViewControllerID") as! CategoryViewController
        case 3, 4:
            let bookList = storyboard?.instantiateViewController(withIdentifier: "BookListViewControllerID") as! BookListViewController
            bookList.type = BookCategory(rawValue: btn.tag)!
            vc = bookList
        default:
            break
        }
        
        /// 跳转
        self.navigationController?.pushViewController(vc, animated: true)
        
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
