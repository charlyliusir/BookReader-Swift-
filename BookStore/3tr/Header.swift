//
//  Header.swift
//  BookStore
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import Fuzi
import Kingfisher

/// 顶点小说:xs

let BASE_URL = "http://www.20xs.cc/book_1_1"       // 玄幻奇幻
let xs_bookurl = "http://www.20xs.cc/book"

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH  = UIScreen.main.bounds.size.width

let navigationTintColor = rgb(35,184,228)
let navigationBarTintColor = rgb(66,113,71)
let backgroundColor = rgb(249,253,240)
let blackColor = hsb(285,0,29)
let grayColor  = hsb(285,0,61)
let textColor  = hsb(194,85,89)
let refreshTintColor = rgb(78,221,200)
let refreshPullColor = rgb(57,67,89)

let titleFont    = font(20)
let subtitleFont = font(18)
let middleFont   = font(16)
let smallFont    = font(14)

// 设置

/// 方法
//--TODO-- 颜色值
func rgb(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
    return rgba(r, g, b, 1)
}
func rgba(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func hsb(_ h:CGFloat,_ s:CGFloat,_ b:CGFloat) -> UIColor {
    return hsba(h, s, b, 1)
}
func hsba(_ h:CGFloat,_ s:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor(hue: h/360.0, saturation: s/100.0, brightness: b/100.0, alpha: a)
}
func font(_ size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

//--TODO-- 小说网址
func book_category(category:UInt, page:UInt) -> String{
    return xs_bookurl + "_" + String(category) + "_" + String(page)
}
func book_search(query:String) -> String{
    return "http://so.23wx.com/cse/search?s=15772447660171623812&entry=1&q=" + query
}


