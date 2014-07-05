//
//  GameScene.swift
//  RGBArtiOS
//
//  Created by Raphael Stäbler on 04.07.14.
//  Copyright (c) 2014 Raphael Stäbler. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    struct Texture {
        var timeIndex:Float
        var texture:SKTexture
    }
    
    var active = false
    
    let bpm:Float = 120
    
    let sampleTexture:SKTexture
    let sprite:SKSpriteNode
    
    var textures = Texture[]()
    var textureIndex = 0
    
    var lastTimeInterval:CFTimeInterval = 0
    
    init(coder:NSCoder) {
        sampleTexture = SKTexture(imageNamed:"sample")
        sprite = SKSpriteNode(texture:sampleTexture);
        super.init(coder:coder)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = SKColor.blackColor()
        
        let frames = Frames(resourceNamed:"Frames")
        let bitmapList = frames.frames
        
        for frame in bitmapList {
            NSLog("%@", frame.data.base64EncodedStringWithOptions(nil))
            let texture = SKTexture(data:frame.data, size: CGSize(width:12, height:9), flipped:true)
            textures += Texture(timeIndex:frame.timeIndex, texture:texture)
        }
        
        //let action = SKAction.animateWithTextures(textures, timePerFrame:0.5)
        
        sprite.xScale = 10
        sprite.yScale = 10
        sprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        //sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite);
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if (active) {
            let texture = textures[textureIndex]
            
            if (Float(currentTime - lastTimeInterval) > texture.timeIndex * 60 / bpm) {
                sprite.texture = texture.texture
                
                textureIndex++
                if (textureIndex == textures.count) {
                    textureIndex = 0
                }
                
                lastTimeInterval = currentTime
            }
        }
    }
    
    func run() {
        textureIndex = 0
        lastTimeInterval = 0
        active = true
    }
    
    func pause() {
        active = false
        sprite.texture = sampleTexture
    }
}
