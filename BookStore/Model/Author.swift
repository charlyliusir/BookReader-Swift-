//
//  Author.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class Author: NSObject {
    /// 作者名
    var name : String?
    /// 作品籍
    let bookArr : Array<Book>? = []
    /// 作者信息链接
    var address : String?
    
    /// 便利构造器
    init(name:String?) {
        if name == nil {
            self.name = "无名"
        }else {
            self.name = name
        }
    }
    
    func class_desc() {
        print("作者名称: \(self.name)")
    }
}
