//
//  SearchViewController.swift
//  BookStore
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    @IBOutlet weak var serachBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        serachBar.showsCancelButton = true
        tableview.register(BookTableViewCell.self, forCellReuseIdentifier: "SearchBookCellID")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SearchViewController:UITableViewDelegate
{
    
}

extension SearchViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBookCellID", for: indexPath) as! BookTableViewCell
        return cell
    }
}

extension SearchViewController:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let data = searchBar.text?.data(using: .utf8, allowLossyConversion: true)
        
        NetKit.post(url: book_search(query: String(bytes: data÷æ‘, encoding: <#T##String.Encoding#>), contants: .HTML) { (make) in
            // 解析
            print(make.data)
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
}
