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
    var data:String
    
    func base64Representation() -> String {
        
        let regex = NSRegularExpression(pattern:"([a-z0-9]{2})\\s+([a-z0-9]{2})\\s+([a-z0-9]{2})\\s+([a-z0-9]{2})", options:NSRegularExpressionOptions.CaseInsensitive, error:nil)
        
        NSLog("%i", regex.numberOfMatchesInString(data, options:NSMatchingOptions.ReportCompletion, range:NSMakeRange(0, countElements(data))))
        
        regex.enumerateMatchesInString(data, options:NSMatchingOptions.ReportCompletion, range:NSMakeRange(0, countElements(data))) {
            (let r, let flags, var stop) in
            if let result:NSTextCheckingResult = r {
                var hex:String = self.data.substringFromIndex(result.range.location)
                hex = hex.substringToIndex(result.range.length) // TODO: use substringWithRange as soon as it works again...
                NSLog("%@", hex)
            }
        }
        
        return data
    }
}

class Frames {
    let frames:Array<Frame>
    
    init(resourceNamed name:String) {
        let resource = NSArray(contentsOfFile:NSBundle.mainBundle().pathForResource(name, ofType:"plist"))
        
        frames = Frame[]()
        
        for entry in resource as NSDictionary[] {
            let timeIndex = entry["timeIndex"] as NSNumber as Int
            let data = entry["data"] as NSString as String
            frames += Frame(timeIndex:timeIndex, data:data)
        }
    }
}