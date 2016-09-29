//
//  TextViewController.swift
//  BookStore
//
//  Created by apple on 16/9/29.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    var book:Book! = nil
    var chapter:Chapter! = nil
    var textView:UITextView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView = UITextView(frame: CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: self.view.frame.size.height-40))
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.isEditable = false
        self.view.addSubview(textView)
        NetKit.get(url: chapter.address!, contants: .HTML) { (response) in
            if let data = response.data{
                UnpackData.unpack_chapter_info(data: data,chapter: &self.chapter!)
                DispatchQueue.main.async(execute: { 
                    self.setText()
                })
            }
        }
        
    }
    
    func setText() -> Swift.Void {
        textView.text = chapter.text
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
