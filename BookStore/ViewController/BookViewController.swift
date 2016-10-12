//
//  BookViewController.swift
//  BookStore
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    var textView:UITextView!
    var size:CGSize!
    var color:UIColor!
    var container:NSTextContainer!
    var text:NSAttributedString!
    var setText:NSAttributedString!{
        set{
            self.text = newValue
            if let view = textView {
                view.attributedText = self.text
            }
        }
        get{
            return self.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView = UITextView(frame: CGRect(x: 10, y: 20, width: size.width, height: size.height), textContainer: container)
        textView.backgroundColor = UIColor.clear
        textView.textColor       = color
        textView.isEditable = false
        if let attributedText = text {
            textView.attributedText = attributedText
        }
        
        self.view.addSubview(textView)
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
