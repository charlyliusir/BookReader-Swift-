//
//  Chapter.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class Chapter: NSObject {
    /// 章节名称
    var name : String?
    /// 最新更新时间
    var date : String?
    /// 更新状态
    var state : String?
    /// 章节地址
    var address : String?
    /// 章节字数
    var number : String?
    /// 章节详情
    var text : String?
    
    func class_desc() {
        
        print("章节名称:\(name)")
        print("更新状态:\(state)")
        print("更新时间:\(date)")
        print("章节地址:\(address)")
        print("章节详情:\(text)")
        
    }
    
}
