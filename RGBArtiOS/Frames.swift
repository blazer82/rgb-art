//
//  Frames.swift
//  RGBArtiOS
//
//  Created by Raphael Stäbler on 04.07.14.
//  Copyright (c) 2014 Raphael Stäbler. All rights reserved.
//

import Foundation

struct Frame {
    var timeIndex:Int
    var data:NSData
}

class Frames {
    let frames:Array<Frame>
    
    init(resourceNamed name:String) {
        let resource = NSArray(contentsOfFile:NSBundle.mainBundle().pathForResource(name, ofType:"plist"))
        
        frames = Frame[]()
        
        for entry in resource as NSDictionary[] {
            let timeIndex = entry["timeIndex"] as NSNumber as Int
            let data = entry["data"] as NSString as String
            
            let regex = NSRegularExpression(pattern:"([a-z0-9]{2})", options:NSRegularExpressionOptions.CaseInsensitive, error:nil)
            
            let numberOfBytes = regex.numberOfMatchesInString(data, options:NSMatchingOptions.ReportCompletion, range:NSMakeRange(0, countElements(data)))
            
            var byteData = Byte[]()
            
            regex.enumerateMatchesInString(data, options:NSMatchingOptions.ReportCompletion, range:NSMakeRange(0, countElements(data))) {
                (let r, let flags, var stop) in
                if let result:NSTextCheckingResult = r {
                    var hex:String = data.substringFromIndex(result.range.location)
                    hex = hex.substringToIndex(result.range.length) // TODO: use substringWithRange as soon as it works again...
                    
                    let scanner = NSScanner(string:hex)
                    var i:UInt32 = 0
                    if (scanner.scanHexInt(&i))
                    {
                        byteData += Byte(i)
                    }
                }
            }

            frames += Frame(timeIndex:timeIndex, data:NSData(bytes: byteData, length: numberOfBytes))
        }
    }
}