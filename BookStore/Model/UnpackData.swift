//
//  UnpackData.swift
//  BookStore
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import Fuzi

class UnpackData {
    /// Book 列表解析
    class public func unpack_book_list(data:Data) -> Array<Book> {
        var bookList:Array<Book> = []
        let nodeLis = self.unpack_book_li(data: data)
        let nodeLi1s = self.unpack_book_li1(nodeSet: nodeLis!)
        for element in nodeLi1s {
            
            var book:Book = Book()
            self.unpack_book_pic(element: element.children[0], book: &book)
            self.unpack_book_nrrk(element: element.children[1], book: &book)
            bookList.append(book)
        }
        
        return bookList
    }
    /// 第一步,解析li标签
    class private func unpack_book_li(data:Data) -> NodeSet? {
        /// 第一步,获取数据解析成XML文档
        let document = try? HTMLDocument(data: data)
        /// 第二步,解析标签为li的所有数据
        return document?.xpath("//li")
    }
    
    /// 第二步,解析li标签的id=“li1”的所有标签
    class private func unpack_book_li1(nodeSet:NodeSet) -> Array<XMLElement> {
        var li1_array:Array<XMLElement> = []
        
        /// 第一步,循环遍历
        for element in nodeSet {
            /// 第二步,判断标签id=“li1”的所有标签
            if element["id"] == "li1" {
                li1_array.append(element)
            }
        }
        
        return li1_array
    }
    /// 第三步,差分解析div class=“pic” 和 div class=“nrrk”
    class private func unpack_book_pic(element:XMLElement, book:inout Book) {
        for child in element.children {
            let imgAddr  = child.firstChild(tag: "img")
            book.name = child["title"]
            book.address = child["href"]
            book.imgAddres = imgAddr?["src"]
        }
    }
    
    class private func unpack_book_nrrk(element:XMLElement, book:inout Book) {
        let childP   = element.firstChild(tag: "p")
        let childDL  = element.firstChild(tag: "dl")
        let childDiv = element.children(tag: "div")
        
        for child in childDiv {
            let classStr = child["class"]
            if classStr == "name"
            {
                self.unpack_book_nrrk_name(element: child, book: &book)
            }
            else if classStr == "num"
            {
                self.unpack_book_nrrk_num(element: child, book: &book)
            }
        }
        
        self.unpack_book_nrrk_p(element: childP!, book: &book)
        self.unpack_book_nrrk_dl(element: childDL!, book: &book)
        
    }
    /// 第四步,差分解析nrrk, div class="name"、div class="num"、p和dl
    /// 解析作者信息
    class private func unpack_book_nrrk_name(element:XMLElement, book:inout Book) {
        let children = element.children(tag: "span")
        let category = children[0].stringValue
        let author   = children[1].firstChild(tag: "a")
        // 1.stringValue 类别：...
        let index     = cgArray.index(of: category.substring(from: category.index(category.startIndex, offsetBy: 3)))
        book.category = BookCategory(rawValue: cgnArray[index!])
        // 2.stringValue 作者
        let bookAuthor:Author = Author(name: author?["title"])
        bookAuthor.address    = author?["href"]
        
        book.author = bookAuthor
    }
    /// 解析OtherInfo
    class private func unpack_book_nrrk_num(element:XMLElement, book:inout Book) {
        let children = element.children(tag: "span")
        
        let other = OtherInfo(number: children[0].stringValue, collection: children[1].stringValue, clicknumber: children[2].stringValue)
        book.otherinfo = other
        
    }
    /// 书籍简介
    class private func unpack_book_nrrk_p(element:XMLElement, book:inout Book) {
        book.bookDesc = element.stringValue
    }
    /// 最新章节
    class private func unpack_book_nrrk_dl(element:XMLElement, book:inout Book) {
//        print("unpack_book_nrrk_dl \(element)")
        let chapter:Chapter = Chapter()
        let child   = element.firstChild(tag: "dt")
        let childI  = child?.firstChild(tag: "i")?.stringValue
        let childA  = child?.firstChild(tag: "a")
        let childEM = child?.firstChild(tag: "em")?.stringValue
        
        chapter.name     = childA?.stringValue
        chapter.address  = childA?["href"]
        chapter.state    = childI
        chapter.date     = childEM
        book.newschapter = chapter
    }
    
    /// Chapter 列表解析
    /// 获取书籍目录目录  【div class=“article_texttitleb”】
    class func unpack_chapter_list(data:Data, book: Book) -> Array<Chapter> {
        var chapterList:Array<Chapter> = []
        let nodeDivs = self.unpack_chapters_div(data: data)
        let nodeDivAT = self.unpack_chapters_divat(nodeSet: nodeDivs!)
        for element in nodeDivAT! {
            let chapter = Chapter();
            chapter.name    = element.stringValue;
            chapter.address = book.address?.appending(element["href"]!)
            chapterList.append(chapter)
        }
        return chapterList
    }
    /// 第一步,解析div标签
    class private func unpack_chapters_div(data:Data) -> NodeSet? {
        /// 第一步,获取数据解析成XML文档
        let document = try? HTMLDocument(data: data)
        /// 第二步,解析标签为li的所有数据
        return document?.xpath("//div")
    }
    /// 第二步,解析 div class=“article_texttitleb”
    class private func unpack_chapters_divat(nodeSet:NodeSet) -> NodeSet? {
        var article_text:XMLElement!
        
        /// 第一步,循环遍历
        for element in nodeSet {
            /// 第二步,判断标签id=“article_texttitleb”的所有标签
            if element["class"] == "article_texttitleb" {
                article_text = element
            }
        }
        
        return article_text.xpath("li/a")
    }
    
    
    /// Chapter 章节信息解析
    class public func unpack_chapter_info(data:Data, chapter:inout Chapter){
        let nodeDivs = unpack_chapter_div(data: data)
        for element in nodeDivs!
        {
            if element["id"] == "book_text" {
                chapter.text = element.stringValue.replacingOccurrences(of: "　　", with: " \n").replacingOccurrences(of: "\r\n        \r\n\t    ", with: "")
                chapter.text?.remove(at: (chapter.text?.startIndex)!)
                chapter.text?.remove(at: (chapter.text?.startIndex)!)
            }else if element["class"] == "data"{
                let nodeset = element.xpath("span")
                chapter.date   = nodeset[3].stringValue
                chapter.number = nodeset[4].stringValue
            }
        }
    }
    
    /// 
    class func unpack_chapter_div(data:Data) -> NodeSet? {
        let document = try? HTMLDocument(data: data)
        return document?.xpath("//div")
    }
}
