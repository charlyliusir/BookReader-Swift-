//
//  BookInfoViewController.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class BookInfoViewController: BaseViewController{
    var book:Book!
    var topContainer:UIView!
    func initTopUI() {
        ///
        topContainer = UIView(frame: CGRect.zero)
        let bookIcon     = UIImageView(frame: CGRect.zero)
        bookIcon.kf.setImage(with: URL(string:book.imgAddres!), placeholder: UIImage(named:"book_placeholder_image"), options: nil, progressBlock: nil, completionHandler: nil)
        let bookInfoContainer = UIView(frame: CGRect.zero)
        let bookName     = UILabel(frame: CGRect.zero)
        let bookInfo     = UILabel(frame: CGRect.zero)
        let bookChapter  = UILabel(frame: CGRect.zero)
        
        topContainer.backgroundColor = UIColor.white
        
        bookName.text    = book.name
        bookInfo.text    = "|  " + (book.author?.name)! + "  |  " + book.category.getString() + "  |  " + (book.otherinfo?.number)! + "  |"
        bookChapter.text = "最新更新：" + (book.newschapter?.name!)!
        
        bookName.font    = titleFont
        bookInfo.font    = smallFont
        bookChapter.font = subtitleFont
        
        bookName.textColor = blackColor
        bookInfo.textColor = grayColor
        bookChapter.textColor = blackColor
        
        self.view.addSubview(topContainer)
        topContainer.addSubview(bookIcon)
        topContainer.addSubview(bookInfoContainer)
        bookInfoContainer.addSubview(bookName)
        bookInfoContainer.addSubview(bookInfo)
        bookInfoContainer.addSubview(bookChapter)
        
        topContainer.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(84)
            make.height.equalTo(140)
        }
        
        bookIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(topContainer)
            make.left.equalTo(topContainer).offset(20)
            make.width.equalTo(52)
            make.height.equalTo(65)
        }
        
        bookInfoContainer.snp.makeConstraints { (make) in
            make.left.equalTo(bookIcon.snp.right).offset(35)
            make.centerY.equalTo(topContainer)
            make.bottom.equalTo(bookChapter)
            make.right.equalTo(topContainer)
        }
        
        bookName.snp.makeConstraints { (make) in
            make.top.equalTo(bookInfoContainer)
            make.left.equalTo(bookInfoContainer)
        }
        
        bookInfo.snp.makeConstraints { (make) in
            make.top.equalTo(bookName.snp.bottom).offset(15)
            make.left.equalTo(bookName)
        }
        
        bookChapter.snp.makeConstraints { (make) in
            make.top.equalTo(bookInfo.snp.bottom).offset(25)
            make.left.equalTo(bookName)
            make.right.equalTo(bookInfoContainer).offset(-10)
        }
    }
    
    func initBottomUI() {
        ///
        let bottomContainer = UIView(frame: CGRect.zero)
        let collectionBtn   = UIButton(type: .custom)
        let readBtn         = UIButton(type: .custom)
        let lineIcon        = UIImageView(image: UIImage(named: "cell_line"))
        let infoLabel       = UILabel(frame: CGRect.zero)
        
        self.view.addSubview(bottomContainer)
        bottomContainer.addSubview(collectionBtn)
        bottomContainer.addSubview(readBtn)
        bottomContainer.addSubview(lineIcon)
        bottomContainer.addSubview(infoLabel)
        
        infoLabel.text = book.bookDesc
        infoLabel.font = middleFont
        infoLabel.textColor = grayColor
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        
        bottomContainer.backgroundColor = UIColor.white
        
        collectionBtn.backgroundColor = rgb(129, 29, 53)
        collectionBtn.setTitle("收藏书架", for: .normal)
        collectionBtn.titleLabel?.font = titleFont
        collectionBtn.setTitleColor(UIColor.white, for: .normal)
        collectionBtn.addTarget(self, action: #selector(collectionAction(sender:)), for: .touchUpInside)
        
        readBtn.backgroundColor = rgb(243, 165, 54)
        readBtn.setTitle("立即阅读", for: .normal)
        readBtn.titleLabel?.font = titleFont
        readBtn.setTitleColor(rgb(183, 233, 141), for: .normal)
        readBtn.addTarget(self, action: #selector(readAction(sender:)), for: .touchUpInside)
        
        bottomContainer.snp.makeConstraints { (make) in
            make.top.equalTo(topContainer.snp.bottom).offset(40)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(infoLabel).offset(15)
        }
        
        collectionBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bottomContainer).offset(15)
            make.left.equalTo(bottomContainer).offset(40)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        
        readBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bottomContainer).offset(10)
            make.right.equalTo(bottomContainer).offset(-40)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        
        lineIcon.snp.makeConstraints { (make) in
            make.left.equalTo(bottomContainer)
            make.right.equalTo(bottomContainer)
            make.top.equalTo(collectionBtn.snp.bottom).offset(10)
        }
        
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineIcon.snp.bottom).offset(10)
            make.left.equalTo(bottomContainer).offset(8)
            make.right.equalTo(bottomContainer).offset(-8)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = book.name
        initTopUI()
        initBottomUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionAction(sender:Any) -> Swift.Void {
        
    }
    
    func readAction(sender:Any) -> Swift.Void {
        // 进入目录
        print("read action")
        let infoVC   = storyboard?.instantiateViewController(withIdentifier: "MainViewControllerID") as! MainViewController
        infoVC.book  = book
        self.present(infoVC, animated: true, completion: nil)
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
