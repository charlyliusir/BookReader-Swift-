//
//  OtherInfo.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class OtherInfo: NSObject {
    /// 字数
    var number : String! = "0"
    /// 收藏
    var collection : String?  = "0"
    /// 点击
    var clicknumber : String? = "0"
    
    /// 便利构造器
    init(number:String) {
        self.number = number
    }
    
    init(number:String?, collection:String?, clicknumber:String?) {
        if let n = number{
            self.number = n
        }
        if let c = collection{
            self.collection = c
        }
        if let cn = clicknumber{
            self.clicknumber = cn
        }
    }
    
    func class_desc() {
        print("总字数 : \(number)")
        print("总收藏 : \(collection)")
        print("总点击 : \(clicknumber)")
    }
    
}
