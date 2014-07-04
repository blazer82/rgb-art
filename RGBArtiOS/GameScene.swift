//
//  GameScene.swift
//  RGBArtiOS
//
//  Created by Raphael Stäbler on 04.07.14.
//  Copyright (c) 2014 Raphael Stäbler. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        var bitmapList = Frame[]()
        
        let frames = Frames(resourceNamed:"Frames")
        for frame in frames.frames {
            bitmapList += frame
        }
        
        var textures = SKTexture[]()
        
        for frame in bitmapList {
            let data = NSData(base64EncodedString:frame.base64Representation(), options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            
            let texture = SKTexture(data:data, size: CGSize(width:12, height:9), flipped:true)
            
            textures += texture
        }
        
        let data = NSData(base64EncodedString:"/wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//", options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let texture = SKTexture(data:data, size: CGSize(width:12, height:9), flipped:true)
        
        let sprite = SKSpriteNode(texture:texture);
        
        let action = SKAction.animateWithTextures(textures, timePerFrame:1)
        
        sprite.xScale = 10.0
        sprite.yScale = 10.0
        sprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite);
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
