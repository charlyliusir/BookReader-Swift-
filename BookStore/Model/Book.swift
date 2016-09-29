//
//  Book.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class Book: NSObject {
    /// 书籍名称
    var name : String!
    /// 书籍分类
    var category : BookCategory!
    /// 作者信息
    var author : Author?
    /// 书籍章节
    var chapters : Array<Chapter>?
    /// 最新章节
    var newschapter : Chapter?
    /// 书籍地址
    var address : String?
    /// 书籍缩略图
    var imgAddres : String?
    /// 书籍简介
    var bookDesc : String?
    /// 书籍其他信息
    var otherinfo:OtherInfo?
    
    func class_desc() {
        print("----------------")
        print("书籍名称 : \(self.name)")
        print("书籍分类 : \(self.category.getString())")
        print("书籍作者 : ------")
        print((self.author?.class_desc()))
        print("书籍作者 : ------")
        print("最新章节 : ------")
        print(self.newschapter?.class_desc())
        print("最新章节 : ------")
        print("书籍地址 : \(self.address)")
        print("书籍缩略图 : \(self.imgAddres)")
        print("书籍简介 : \(self.bookDesc)")
        print("书籍其他信息-----")
        print(self.otherinfo?.class_desc())
        print("书籍其他信息-----")
        print("书籍目录--------")
        print(self.chapters)
        print("书籍目录--------")
        print("----------------")
    }
    
}
