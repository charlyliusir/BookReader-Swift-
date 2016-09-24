//
//  NetKit.swift
//  BookStore
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit
import Alamofire
// 功能描述:Swift版网络请求封装,基于Alamofire二次封装
// 包含功能:
/// 1.网络请求[Get/Post]=>返回数据JSON/XML
/// 2.下载
/// 3.上传

public typealias CLValueType = Dictionary<String,Any>

class NetKit: NSObject {
    /// 匿名函数返回值类型
    public struct CLDataResponse {
        public let data:Data?
        public let value:CLValueType?
    }
    /// 返回值类型
    public enum NetContants {
        case JSON, XML, HTML, DATA
    }
    /// 1. Get请求,无参,其他值为默认
    func get(url: URLConvertible, contants:NetContants) -> ((NetKit.CLDataResponse) -> Swift.Void){
        return request(url: url, method: .get, contants: contants, parameters: nil, encoding: URLEncoding(), headers: nil)
    }
    
    func request(url: URLConvertible, method: HTTPMethod, contants:NetContants, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> ((NetKit.CLDataResponse) -> Swift.Void) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response) in
//            return (NetKit.CLDataResponse) -> Swift.Void{
        }
    }
    
}
