//
//  MainGameScene.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 12/19/18.
//  Copyright © 2018 SonPham. All rights reserved.
//
// Man hinh chinh cua game 
import UIKit
import GameplayKit
import Foundation
protocol delegateGame {
    func item4ClickDelegate(_viewController:SKScene)
}
class MainGameScene: SKScene {
   
    
    var gameIsPaused:Bool = false
    
    var swipeFromColumn: Int?
    var swipeFromRow: Int?
    
    var level:Level!
    
    let gameLayer = SKNode()
    let diamondsLayer = SKNode()
    let buttonItemLayer = SKNode()
    
    let TileWidth: CGFloat = 43.0
    let TileHeight: CGFloat = 43.0
    
     var swipeHandler: ((Swap) -> ())?
    //MARK: texture Button Item
    let textureButtonItem1 = SKTexture(imageNamed: "buttonItem1")
    let textureButtonItem2 = SKTexture(imageNamed: "buttonItem2")
    let textureButtonItem3 = SKTexture(imageNamed: "buttonItem3")
    let textureButtonItem4 = SKTexture(imageNamed: "buttonItem4")
    
    //MARK: button pause game
    
    let textureButtonPauseGame = SKTexture(imageNamed: "pauseButton")
    
    override init(size: CGSize) {
        print("khoi tao game")
        super.init(size: size)
        anchorPoint = CGPoint(x:0.5,y:0.5)
        //MARK: ADD BACKGROUND
        let background = SKSpriteNode(imageNamed: "BackgroundMainGame")
        background.size = size
        addChild(background)
        
        let BackgroundDiamond = SKSpriteNode(imageNamed: "backgroundingame")
        BackgroundDiamond.setScale(0.6)
        BackgroundDiamond.position=CGPoint(x: 0.5, y: 0.5)
        
        background.addChild(BackgroundDiamond)
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)
        diamondsLayer.position = layerPosition
        
        addChild(gameLayer)
       // AddItemButtonToLayer()
        gameLayer.addChild(diamondsLayer)
        //gameLayer.addChild(buttonItemLayer)
        swipeFromRow=nil
        swipeFromColumn=nil
        let _ = SKLabelNode(fontNamed: "GillSans-BoldItalic")
        

        
    }
    func AddItemButtonToLayer(){
        let ButtonItem1 = SKButtonNode(texture: textureButtonItem1) {
            print("Button play pressed!")
        }
        ButtonItem1.setScale(CGFloat(0.6))// ham nay thu nho button
        ButtonItem1.position = CGPoint(x: -120 ,y: -290.0)
        buttonItemLayer.addChild(ButtonItem1)
        let ButtonItem2 = SKButtonNode(texture: textureButtonItem2) {
            print("Button play pressed!")
        }
        ButtonItem2.setScale(CGFloat(0.6))// ham nay thu nho button
        ButtonItem2.position = CGPoint(x: -40 ,y: -290.0)
        buttonItemLayer.addChild(ButtonItem2)
        
        let ButtonItem3 = SKButtonNode(texture: textureButtonItem3) {
            print("Button play pressed!")
        }
        ButtonItem3.setScale(CGFloat(0.6))// ham nay thu nho button
        ButtonItem3.position = CGPoint(x: 40 ,y: -290.0)
        buttonItemLayer.addChild(ButtonItem3)
        
        let ButtonItem4 = SKButtonNode(texture: textureButtonItem4) {
            
        }
        ButtonItem4.setScale(CGFloat(0.6))// ham nay thu nho button
        ButtonItem4.position = CGPoint(x: 120 ,y: -290.0)
        buttonItemLayer.addChild(ButtonItem4)
        
        
//        let ButtonPauseGame = SKButtonNode(texture: textureButtonPauseGame) {
//            print("Button pause game pressed!")
//            self.PauseGame()
//        }
//        ButtonPauseGame.setScale(CGFloat(0.08))// ham nay thu nho button
//        ButtonPauseGame.position = CGPoint(x: 140 ,y: 300.0)
//        buttonItemLayer.addChild(ButtonPauseGame)
       
    }
    func UseItem4(){
        print("Show hint")
        if ConstantGame.item4Number >= 1{
            // tru so lan di
            ConstantGame.item4Number = ConstantGame.item4Number - 1
            
            let hint1:SKSpriteNode=SKSpriteNode(imageNamed: "Hint")
            hint1.size=CGSize(width: self.TileWidth, height: self.TileHeight)
            let hint2:SKSpriteNode=SKSpriteNode(imageNamed: "Hint")
            hint2.size=CGSize(width: self.TileWidth, height: self.TileHeight)
            let pos = self.level.hintDiamond()
            hint1.position =  self.PositionForEachDiamond(column: Int(pos.posA.x), row: Int(pos.posA.y))
            hint2.position =  self.PositionForEachDiamond(column: Int(pos.posB.x), row: Int(pos.posB.y))
            //let appear = SKAction.fadeAlpha(to: 0.8, duration: 0.5)
            //appear.timingMode = .easeOut
            //hint.run(appear)
            self.diamondsLayer.addChild(hint1)
            self.diamondsLayer.addChild(hint2)
            let moveAction = SKAction.move(by: CGVector(dx: 0, dy: 1), duration: 1)
            moveAction.timingMode = .easeOut
            hint1.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
            hint2.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        }
        
    }
    
    func AddSpritesForDiamond(for diamonds:Set<Diamond>){
        for diamond in diamonds{
            let sprite = SKSpriteNode(imageNamed: diamond.diamondType.spriteName)
            sprite.size=CGSize(width: TileWidth, height: TileHeight)
            sprite.position = PositionForEachDiamond(column:diamond.column,row: diamond.row)
            diamondsLayer.addChild(sprite)
            diamond.sprite=sprite
        }
    }
    
    func PositionForEachDiamond(column:Int,row:Int) -> CGPoint
    {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
    
    func PositionToPoint(_ point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileHeight {
            return (true, Int(point.x / TileWidth), Int(point.y / TileHeight))
        } else {
            return (false, 0, 0)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: controller game
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: diamondsLayer)
        
        let (success, column, row) = PositionToPoint(location)
        if success {
            if let diamond = level.diamondAt(column: column, row: row) {
                swipeFromColumn = column
                swipeFromRow = row
                //showSelectionIndicator(for: cookie)
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard swipeFromColumn != nil else { return }
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: diamondsLayer)
        
        let (success, column, row) = PositionToPoint(location)
        if success {
            var horzDelta = 0, vertDelta = 0
            if column < swipeFromColumn! {          // swipe left
                horzDelta = -1
            } else if column > swipeFromColumn! {   // swipe right
                horzDelta = 1
            } else if row < swipeFromRow! {         // swipe down
                vertDelta = -1
            } else if row > swipeFromRow! {         // swipe up
                vertDelta = 1
            }
            
            if horzDelta != 0 || vertDelta != 0 {
                trySwap(horizontal: horzDelta, vertical: vertDelta)
                //hideSelectionIndicator()
                
                swipeFromColumn = nil
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        swipeFromColumn = nil
        swipeFromRow = nil
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
          touchesEnded(touches, with: event)
    }
   
    func trySwap(horizontal horzDelta: Int, vertical vertDelta: Int) {
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + vertDelta
        
        guard toColumn >= 0 && toColumn < NumColumns else { return }
        guard toRow >= 0 && toRow < NumRows else { return }
        
        if let toDiamond = level.diamondAt(column: toColumn, row: toRow),
            let fromDiamond = level.diamondAt(column: swipeFromColumn!, row: swipeFromRow!),
            let handler = swipeHandler {
            let swap = Swap(diamondA: fromDiamond, diamondB: toDiamond)
            handler(swap)
        }
    }
    func animate(_ swap: Swap, completion: @escaping () -> ()) {
        let spriteA = swap.diamondA.sprite!
        let spriteB = swap.diamondB.sprite!
        
        spriteA.zPosition = 100
        spriteB.zPosition = 90
        
        let duration: TimeInterval = 0.3
        
        let moveA = SKAction.move(to: spriteB.position, duration: duration)
        moveA.timingMode = .easeOut
        spriteA.run(moveA, completion: completion)
        
        let moveB = SKAction.move(to: spriteA.position, duration: duration)
        moveB.timingMode = .easeOut
        spriteB.run(moveB)
        
        //run(swapSound)
    }
    func animateInvalidSwap(_ swap:Swap, completion:@escaping ()->()){
        let spriteA = swap.diamondA.sprite!
        let spriteB = swap.diamondB.sprite!
        
        spriteA.zPosition = 100
        spriteB.zPosition = 90
        
        let duration: TimeInterval = 0.2
        
        let moveA = SKAction.move(to: spriteB.position, duration: duration)
        moveA.timingMode = .easeOut
        
        let moveB = SKAction.move(to: spriteA.position, duration: duration)
        moveB.timingMode = .easeOut
        
        spriteA.run(SKAction.sequence([moveA, moveB]), completion: completion)
        spriteB.run(SKAction.sequence([moveB, moveA]))
        
        //run(invalidSwapSound)
    }
   
    func animateGameOver(_ completion: @escaping () -> ()) {
        let action = SKAction.move(by: CGVector(dx: 0, dy: -size.height), duration: 0.3)
        action.timingMode = .easeIn
        diamondsLayer.run(action, completion: completion)
    }
    func removeAllDiamondSprites() {
        diamondsLayer.removeAllChildren()
    }
    
    func animateMatchedCookies(for chains: Set<Chain>, completion: @escaping () -> ()) {
        for chain in chains {
            
            animateScore(for: chain)
            
            for diamond in chain.diamonds {
                if let sprite = diamond.sprite {
                    if sprite.action(forKey: "removing") == nil {
                        let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                        scaleAction.timingMode = .easeOut
                        
                        sprite.run(SKAction.sequence([scaleAction, SKAction.removeFromParent()]), withKey: "removing")
                    }
                }
            }
        }
        //run(matchSound)
        run(SKAction.wait(forDuration: 0.3), completion: completion)
    }
    
    func animateFallingDiamonds(columns: [[Diamond]], completion: @escaping () -> ()) {
        var longestDuration: TimeInterval = 0
        
        for array in columns {
            for (idx, diamond) in array.enumerated() {
                let newPosition = PositionForEachDiamond(column: diamond.column, row: diamond.row)
                
                let delay = 0.05 + 0.15 * TimeInterval(idx)
                
                let sprite = diamond.sprite!
                
                let duration = TimeInterval(((sprite.position.y - newPosition.y) / TileHeight) * 0.1)
                
                longestDuration = max(longestDuration, duration + delay)
                
                let moveAction = SKAction.move(to: newPosition, duration: duration)
                moveAction.timingMode = .easeOut
                sprite.run(SKAction.sequence([SKAction.wait(forDuration: delay), SKAction.group([moveAction])]))
            }
        }
        
        run(SKAction.wait(forDuration: longestDuration), completion: completion)
    }
    
    
    func animateNewCookies(_ columns: [[Diamond]], completion: @escaping () -> ()) {
        var longestDuration: TimeInterval = 0
        
        for array in columns {
            let startRow = array[0].row + 1
            
            for (idx, diamond) in array.enumerated() {
                let sprite = SKSpriteNode(imageNamed: diamond.diamondType.spriteName)
                sprite.size = CGSize(width: TileWidth, height: TileHeight)
                sprite.position = PositionForEachDiamond(column: diamond.column, row: startRow)
                diamondsLayer.addChild(sprite)
                diamond.sprite = sprite
                
                let delay = 0.1 + 0.2 * TimeInterval(array.count - idx - 1)
                
                let duration = TimeInterval(startRow - diamond.row) * 0.1
                longestDuration = max(longestDuration, duration + delay)
                
                let newPosition = PositionForEachDiamond(column: diamond.column, row: diamond.row)
                let moveAction = SKAction.move(to: newPosition, duration: duration)
                moveAction.timingMode = .easeOut
                sprite.alpha = 0
                sprite.run(SKAction.sequence([SKAction.wait(forDuration: delay), SKAction.group([SKAction.fadeIn(withDuration: 0.05), moveAction])]))
            }
        }
        
        run(SKAction.wait(forDuration: longestDuration), completion: completion)
    }
    
    func animateScore(for chain: Chain) {
        let firstSprite = chain.firstDiamond().sprite!
        let lastSprite = chain.lastDiamond().sprite!
        let centerPosition = CGPoint(x: (firstSprite.position.x + lastSprite.position.x)/2, y: (firstSprite.position.y + lastSprite.position.y)/2)
        
        let scoreLabel = SKLabelNode(fontNamed: "GillSans-BoldItalic")
        scoreLabel.fontSize = 16
        scoreLabel.text = String(format: "%ld", chain.score)
        scoreLabel.position = centerPosition
        scoreLabel.zPosition = 300
        diamondsLayer.addChild(scoreLabel)
        
        let moveAction = SKAction.move(by: CGVector(dx: 0, dy: 3), duration: 0.7)
        moveAction.timingMode = .easeOut
        
        scoreLabel.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
    }
    //PAUSE GAME
    
    
    func PauseGame(){
        gameIsPaused = true
        isPaused = gameIsPaused
       // let pauseMenu = MenuGameScene(size: (view?.bounds.size)!)
        //pauseMenu.scaleMode = .aspectFill
        //self.view?.presentScene(pauseMenu, transition: SKTransition.fade(withDuration: 0.5))
    }
    
    //MARK: UnpauseGame
    func UnPauseGame(){
        gameIsPaused = false
        isPaused = gameIsPaused
        
    }
    func pauseButtonPressed(sender: AnyObject){
        if !gameIsPaused{
            PauseGame()
        }
        else{
            UnPauseGame()
        }
    }
    
    
}
