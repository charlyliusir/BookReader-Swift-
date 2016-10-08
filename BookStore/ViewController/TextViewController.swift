//
//  TextViewController.swift
//  BookStore
//
//  Created by apple on 16/9/29.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    var textView:UITextView! = nil
    var text:NSAttributedString?
    var font:UIFont!
    var size:CGSize!
    var color:UIColor!
    var container:NSTextContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView = UITextView(frame: CGRect(x: 10, y: 10, width: size.width, height: size.height), textContainer: container)
        textView.attributedText = text!
        textView.font           = font
        textView.textColor      = color
        textView.isEditable = false
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
