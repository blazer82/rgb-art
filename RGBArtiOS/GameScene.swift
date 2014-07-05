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
        self.backgroundColor = SKColor.blackColor()
        
        let frames = Frames(resourceNamed:"Frames")
        let bitmapList = frames.frames
        
        var textures = SKTexture[]()
        
        for frame in bitmapList {
            let texture = SKTexture(data:frame.data, size: CGSize(width:12, height:9), flipped:true)
            textures += texture
        }
        
        let sprite = SKSpriteNode(imageNamed:"sample");
        
        let action = SKAction.animateWithTextures(textures, timePerFrame:0.5)
        
        sprite.xScale = 1.0
        sprite.yScale = 1.0
        sprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite);
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
