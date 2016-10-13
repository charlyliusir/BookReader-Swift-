//
//  ChapterListViewController.swift
//  BookStore
//
//  Created by 刘朝龙 on 2016/10/13.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

protocol ChapterListDelegate {
    @available(iOS 2.0, *)
    func chapterListVC(_ chapterListVC:ChapterListViewController, selectChapter item:Int) -> Swift.Void
}

class ChapterListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var delegate:ChapterListDelegate?
    var titleName:String!
    var dataRows:Array<Any>? = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 44))
        titleLabel.text = titleName
        titleLabel.textAlignment = .center
        titleLabel.textColor = navigationTintColor
        self.navigationItem.titleView = titleLabel
        tableView.register(UINib(nibName: "ChapterListCell", bundle: Bundle(for: ChapterListCell.self)), forCellReuseIdentifier: "ChapterCell")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "回到顶部", style: .plain, target: self, action: #selector(scrollToTop))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "回到底部", style: .plain, target: self, action: #selector(scrollToBottom))
    }

    @IBAction func cancelAction(_ sender: AnyObject) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollToTop() -> Swift.Void {
        
    }
    
    func scrollToBottom() -> Swift.Void {
        
    }
    @IBAction func dissMissAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// table delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 点击选中
        self.delegate?.chapterListVC(self, selectChapter: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }

    /// data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataRows?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chapter = dataRows?[indexPath.row] as! Chapter
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell", for: indexPath) as! ChapterListCell
        cell.nameTitle = chapter.name
        cell.setStyle()
        return cell
    }
    
}
