//
//  GameScene.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 12/8/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //MARK: Button in MENU GAME
    let texturePlayButton = SKTexture(imageNamed: "playButton")
    let textureSettingButton = SKTexture(imageNamed: "settingButton")
    let textureBestScoreButton = SKTexture(imageNamed: "bestScoreButton")
    
    
    
    
    override init(size: CGSize) {
        
        super.init(size: size)
        anchorPoint = CGPoint(x:0.5,y:0.5)
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = size
        addChild(background)
        //MARK:Create button menu
        //Button play
        let ButtonPlayGame = SKButtonNode(texture: texturePlayButton) {
            print("Button play pressed!")
            self.PlayGame()
        }
        ButtonPlayGame.setScale(CGFloat(0.6))// ham nay thu nho button
        ButtonPlayGame.position = CGPoint(x: 0.5 ,y: -180.0)
        addChild(ButtonPlayGame)
        //Button Setting
        let ButtonSettingGame = SKButtonNode(texture: textureSettingButton) {
            print("Button setting pressed!")
        }
        ButtonSettingGame.setScale(CGFloat(0.6))// ham nay thu nho button
        ButtonSettingGame.position = CGPoint(x: -100 ,y: -260.0)
        addChild(ButtonSettingGame)
        //Button Best Score
        let ButtonBestScoreGame = SKButtonNode(texture: textureBestScoreButton) {
            print("Button best score pressed!")
        }
        ButtonBestScoreGame.setScale(CGFloat(0.6))// ham nay thu nho button
        ButtonBestScoreGame.position = CGPoint(x: 100 ,y: -260.0)
        addChild(ButtonBestScoreGame)
        //
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func PlayGame(){
        let Main = MainGameScene(size: (view?.bounds.size)!)
        Main.scaleMode = .aspectFill
        self.view?.presentScene(Main, transition: SKTransition.fade(withDuration: 0.2))
        
        
    }
}
