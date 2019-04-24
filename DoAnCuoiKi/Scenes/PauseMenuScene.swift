//
//  PauseMenuScene.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 1/1/19.
//  Copyright © 2019 SonPham. All rights reserved.
//

import Foundation
import GameplayKit

class MenuGameScene:SKScene{
    
    //MARK: Button
    let textureCloseButton = SKTexture(imageNamed: "closeButtonMenu")
    let textureSettingButton = SKTexture(imageNamed: "settingButtonMenu")
    let textureContinueButton = SKTexture(imageNamed: "continueButtonMenu")
    let textureHomeButton = SKTexture(imageNamed: "homeButtonMenu")
   
    //MARK: Background
    let dashBoard = SKSpriteNode(imageNamed: "pauseGameboard")
    let background = SKSpriteNode(imageNamed: "menuBG")
    
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x:0.5,y:0.5)
        background.size = size
        addChild(background)
        
        dashBoard.setScale(CGFloat(0.7))
        dashBoard.position = CGPoint(x:0,y:0)
        addChild(dashBoard)
        AddButton()
    }
    func AddButton(){
        let CloseButton = SKButtonNode(texture: textureCloseButton) {
            print("Button play pressed!")
        }
        CloseButton.setScale(CGFloat(0.6))// ham nay thu nho button
        CloseButton.position = CGPoint(x: 110 ,y: 70)
        addChild(CloseButton)
        
        let SettingButton = SKButtonNode(texture: textureSettingButton) {
            print("Button play pressed!")
        }
        SettingButton.setScale(CGFloat(0.7))// ham nay thu nho button
        SettingButton.position = CGPoint(x: 0 ,y: 0)
        addChild(SettingButton)
        
        let HomeButton = SKButtonNode(texture: textureHomeButton) {
            print("Button play pressed!")
        }
        HomeButton.setScale(CGFloat(0.7))// ham nay thu nho button
        HomeButton.position = CGPoint(x: -80 ,y: 0)
        addChild(HomeButton)
        
        let ContinueButton = SKButtonNode(texture: textureContinueButton) {
            print("Button play pressed!")
        }
        ContinueButton.setScale(CGFloat(0.7))// ham nay thu nho button
        ContinueButton.position = CGPoint(x: 80 ,y: 0)
        addChild(ContinueButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
