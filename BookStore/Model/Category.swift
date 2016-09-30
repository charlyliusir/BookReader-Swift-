//
//  Category.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import Foundation

let cgArray : Array<String> = ["玄幻魔法", "武侠修真", "言情都市", "历史穿越", "网游动漫", "科幻小说", "恐怖灵异", "其他小说", "排行榜", "最近阅读"]
let cgnArray: Array<Int> = [1,2,3,4,6,7,8,10,11,12]

enum BookCategory : Int {
    case Fantasy_Magic = 1                      /*玄幻魔法*/
    case Martial_Arts_Comprehension             /*武侠修真*/
    case Sentimental_City                       /*言情都市*/
    case Historical_Crossing                    /*历史穿越*/
    case Online_Animation = 6                   /*网游动漫*/
    case High_Fidelity                          /*科幻小说*/
    case Supernatural_Horror                    /*恐怖灵异*/
    case Other = 10                             /*其他小说*/
    case Charts                                 /*排行榜*/
    case Read                                   /*最近阅读*/
    
    func getString() -> String {
        let index = cgnArray.index(of: self.rawValue)
        return cgArray[index!]
    }
}
