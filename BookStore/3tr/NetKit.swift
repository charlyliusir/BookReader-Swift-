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

/// 匿名函数返回值类型
public struct CLDataResponse {
    public var data:Data?
    public var value:CLValueType?
}
/// 返回值类型
public enum NetContants {
    case JSON, XML, HTML, DATA
}
class NetKit{
    
    /// 解析返回数据
    class func unPackResponse(_ contants:NetContants, _ response: DataResponse<Data>) -> CLDataResponse {
        
        var packData = CLDataResponse(data: response.result.value, value: nil)
        
        switch contants {
        case .XML, .JSON: break
        case .HTML:
            if let data = response.result.value {
                var buffer = Array<UInt8>(repeating: 0x00, count: data.count)
                data.copyBytes(to: &buffer, count: data.count)
                let gbkStr = CFStringCreateWithBytes(kCFAllocatorDefault, buffer, data.count, (CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)), false)
                if let gbk = gbkStr{
                    
                    var dataString:String? = gbk as String
                    
                    dataString = dataString?.replacingOccurrences(of: "gb2312", with: "utf-8", options:String.CompareOptions.literal, range: nil)
                    
                    packData.data = dataString?.data(using: .utf8, allowLossyConversion: false)
                    
                }
                
            }
        default:
            break;
            
        }
        
        return packData
        
    }
    class func unPackResponse(_ contants:NetContants, _ response: DataResponse<Any>) -> CLDataResponse {
        
        var packData = CLDataResponse(data: response.data, value: nil)
        
        switch contants {
            
        case .JSON:
            packData.value = response.result.value as! CLValueType?
        default: break
            
        }
        
        return packData
    }
    
    /// 1. Get请求,无参,其他值为默认
    @discardableResult
    class func get(url: URLConvertible,
             contants:NetContants,
             response:@escaping ((CLDataResponse) -> Swift.Void)){
        
        get(url:url,
            contants: contants,
            parameters: nil,
            response: response)
        
    }
    /// 2. Get请求,有参,其他值为默认
    class public func get(url: URLConvertible,
                    contants:NetContants,
                    parameters:Parameters?,
                    response:@escaping ((CLDataResponse) -> Swift.Void)){
        
        request(url:url,
                contants: contants,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: nil,
                responseBlock: response)
        
    }
    /// 1. POST请求,无参,其他值为默认
    class public func post(url: URLConvertible,
                     contants:NetContants,
                     response:@escaping ((CLDataResponse) -> Swift.Void)){
        
        post(url:url,
             contants: contants,
             parameters: nil,
             response: response)
        
    }
    /// 2. POST请求,有参,其他值为默认
    class public func post(url: URLConvertible,
                     contants:NetContants,
                     parameters:Parameters?,
                     response:@escaping ((CLDataResponse) -> Swift.Void)){
        
        request(url:url,
                contants: contants,
                method: .post,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: nil,
                responseBlock: response)
        
    }
    
    /// 网络请求,通过URL,返回类型,请求方法,编码格式等请求并返回数据
    class func request(url:URLConvertible,
                 contants:NetContants,
                 method:HTTPMethod,
                 parameters:Parameters?,
                 encoding:ParameterEncoding,
                 headers:HTTPHeaders?,
                 responseBlock:@escaping ((CLDataResponse) -> Swift.Void)){
        
        let result:DataRequest = Alamofire.request(url,
                                                   method: method,
                                                   parameters: parameters,
                                                   encoding: encoding,
                                                   headers: headers)
        
        switch contants {
        case .XML,.HTML,.DATA:
            result.responseData(completionHandler: { (response) in
                responseBlock(unPackResponse(contants, response))
            })
        case .JSON:
            result.responseJSON(completionHandler: { (response) in
                responseBlock(unPackResponse(contants, response))
            })
        }
        
    }
}



