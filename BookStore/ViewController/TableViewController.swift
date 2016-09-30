//
//  TableViewController.swift
//  BookStore
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

/// 所有拥有TableViewVC的父视图

class TableViewController: BaseViewController {
    var tableView:UITableView!
    var loadingView:DGElasticPullToRefreshLoadingViewCircle!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = refreshTintColor
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(self.tableView)
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
