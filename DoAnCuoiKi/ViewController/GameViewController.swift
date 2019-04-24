//
//  GameViewController.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 12/8/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
    
    
    var pauseGameViewController: PauseGameViewController!
    
    var Scene:GameScene!
    var SceneGame:MainGameScene!
    var level:Level!
    var TimerGame = Timer()
    var loseGame = false//bien thua game
    // button panel
    @IBOutlet weak var NextLevelButtonPanel: UIButton!
    @IBOutlet weak var PlayAgainButtonPanel: UIButton!
    @IBOutlet weak var MenuButtonPanel: UIButton!
    
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textScoreLabel: UILabel!
    @IBOutlet weak var textMoveLabel: UILabel!
    @IBOutlet weak var textTargerLabel: UILabel!
    @IBOutlet weak var PanelGameOver: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var textTimeLabel: UILabel!
    
    // number item
    @IBOutlet weak var item1NumberLabel: UILabel!
    @IBOutlet weak var item2NumberLabel: UILabel!
    @IBOutlet weak var item3NumberLabel: UILabel!
    @IBOutlet weak var item4NumberLabel: UILabel!
    
   
    var score:Int = 0
    var move:Int = 0
    var seconds:Int = 0
   
    // next level
    @IBAction func NextLevelClick(_ sender: UIButton) {
        hideGameOver()
        AddNumberItem()
        SetNumberItem()
        ConstantGame.numberLevel = ConstantGame.numberLevel + 1
        NextLevelGame(levelGame: ConstantGame.numberLevel, mode: ConstantGame.modeGame)
        
    }
    // play again click
    @IBAction func PlayAgainClick(_ sender: UIButton) {
        let notificationGame = UIAlertController(title: "Notifications", message: "Do you want to play again", preferredStyle: .alert)
        
        notificationGame.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.BeginGame()
            
            
        }))
        notificationGame.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil ))
        self.present(notificationGame, animated: true, completion: nil)
       
    }
    
    //button  item game
    
    @IBAction func item4Click(_ sender: UIButton) {
        if ConstantGame.item4Number == 0{
            let notificationGame = UIAlertController(title: "Notifications", message: "You dont have item !!!", preferredStyle: .alert)
            notificationGame.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(notificationGame, animated: true, completion: nil)
        }
        else
        {
            SceneGame.UseItem4()
            SetNumberItem()
        }
       
    }
    
    @IBAction func item3Click(_ sender: UIButton) {
        if ConstantGame.modeGame == .Time{
            if ConstantGame.item3Number >= 1{
                level.time=level.time + 5
                ConstantGame.item3Number = ConstantGame.item3Number - 1
                SetNumberItem()
            }
            else{
                let notificationGame = UIAlertController(title: "Notifications", message: "You dont have item !!!", preferredStyle: .alert)
                notificationGame.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                self.present(notificationGame, animated: true, completion: nil)
            }
          
        }
        else {
            let notificationGame = UIAlertController(title: "Notifications", message: "Item only use for time mode", preferredStyle: .alert)
            notificationGame.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(notificationGame, animated: true, completion: nil)
        }
    }
    @IBAction func item2Click(_ sender: UIButton) {
        if ConstantGame.item2Number >= 1{
            ConstantGame.doubelScore = true
            ConstantGame.item2Number = ConstantGame.item2Number - 1
             SetNumberItem()
        }
        else
        {
            let notificationGame = UIAlertController(title: "Notifications", message: "You dont have item !!!", preferredStyle: .alert)
            notificationGame.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(notificationGame, animated: true, completion: nil)
        }
        
    }
    @IBAction func item1Click(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pauseGameViewController = storyboard?.instantiateViewController(withIdentifier: "ID_PauseGameViewController") as? PauseGameViewController
         pauseGameViewController.delegate = self
        if let view = self.view as! SKView? {
          
            PanelGameOver.isHidden = true
            view.isMultipleTouchEnabled=false
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
//            Scene = GameScene(size: view.bounds.size)
//            Scene.scaleMode = .aspectFill
//            view.presentScene(Scene)
            SceneGame=MainGameScene(size:view.bounds.size)
            SceneGame.scaleMode = .aspectFill
            level = Level(filename: "Level\(1)\(ConstantGame.modeGame.NameMode)",modeGame: ConstantGame.modeGame)
            SceneGame.level = level
            SceneGame.swipeHandler = handleSwipe(_:)
            view.presentScene(SceneGame)
            
        }
        BeginGame()
    }
    // ham bat dau game
    func BeginGame(){
        SetNumberItem()
        levelLabel.text = "Level " + String(ConstantGame.numberLevel)
        shuffle()
        SetTypeGame()
        SetViewControllerGame()
        UpdateLabel()
        
    }
    func SetViewControllerGame(){
        if ConstantGame.modeGame == .Classic{
            textMoveLabel.isHidden=true
            textScoreLabel.isHidden=false
            textTargerLabel.isHidden=false
            textTimeLabel.isHidden=true
            
            moveLabel.isHidden=true
            scoreLabel.isHidden=false
            targetLabel.isHidden=false
            timeLabel.isHidden=true
            
        }
        else if ConstantGame.modeGame == .Limit{
            textMoveLabel.isHidden=false
            textScoreLabel.isHidden=false
            textTargerLabel.isHidden=false
            textTimeLabel.isHidden=true
            
            moveLabel.isHidden=false
            scoreLabel.isHidden=false
            targetLabel.isHidden=false
            timeLabel.isHidden=true
        }
        else if ConstantGame.modeGame == .Time{
            textMoveLabel.isHidden=true
            textScoreLabel.isHidden=false
            textTargerLabel.isHidden=false
            textTimeLabel.isHidden=false
            
            moveLabel.isHidden=true
            scoreLabel.isHidden=false
            targetLabel.isHidden=false
            timeLabel.isHidden=false
            
            
        }
    }
    // ham xet trang thai game cho tung loai game
    func SetTypeGame(){
        if ConstantGame.modeGame == .Classic{
            score = 0
           
        }
        else if ConstantGame.modeGame == .Limit{
            score = 0
            move = level.maximunMove
        }
        else if ConstantGame.modeGame == .Time{
            score = 0
            seconds = level.time
            TimerGame = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.Clock), userInfo: nil, repeats: true)
            
        }
        
    }
    //Ham nay dung de dem thoi gian trong che do time
    @objc func Clock(){
        seconds=seconds-1
        timeLabel.text = String(seconds)
        if seconds==0{
            print("thua")
            TimerGame.invalidate()
            loseGame = true
            PanelGameOver.image = UIImage(named: "gameoverPanel")
            showGameOver()
        }
        
    }
    func shuffle(){
        SceneGame.removeAllDiamondSprites()
        let newDiamonds=level.shuffle()
        SceneGame.AddSpritesForDiamond(for: newDiamonds)
    }
    
    func handleSwipe(_ swap: Swap) {
        view.isUserInteractionEnabled = false
        
        if level.isPossibleSwap(swap){
            level.performSwap(swap)
            SceneGame.animate(swap,completion: handleMathes)
        }
        else{
            SceneGame.animateInvalidSwap(swap, completion:{
                self.view.isUserInteractionEnabled = true
            })
        }
        
    }
    
    func handleMathes() {
        let chains = level.removeMatches()
        if chains.count == 0 {
            beginNextTurn()
            return
        }
      
        SceneGame.animateMatchedCookies(for: chains) {
            
           
            self.CalculateScorePlayer(for: chains)
            let columns = self.level.fillHoles()
            self.SceneGame.animateFallingDiamonds(columns: columns, completion: {
                let columns = self.level.topUpCookies()
                self.SceneGame.animateNewCookies(columns, completion: {
                    self.handleMathes()
                })
            })
            
        }
    }
    // ham bat dau di chuyen kim cuong
    func beginNextTurn() {
        //level.resetComboMultiplier()
        level.detectPossibleSwaps()
        view.isUserInteractionEnabled = true
        CheckGame()
       
    }
    // ham hien thi panel thua
    func showGameOver() {
        //shuffleButton.isHidden = true
        PanelGameOver.isHidden = false
        //3 nut panel
        MenuButtonPanel.isHidden = false
        if loseGame == true{
            NextLevelButtonPanel.isHidden = true
        }
        else {
            NextLevelButtonPanel.isHidden = false
        }
        
        PlayAgainButtonPanel.isHidden = false
        SceneGame.isUserInteractionEnabled = false
    
        SceneGame.animateGameOver{}
        
       
       
    }
    //an panel
    func hideGameOver() {
        MenuButtonPanel.isHidden = true
        NextLevelButtonPanel.isHidden = true
        PlayAgainButtonPanel.isHidden = true
        PanelGameOver.isHidden = true
        SceneGame.isUserInteractionEnabled = true
    }
    //MARK: Show VC
    func ShowViewController(viewController: PauseGameViewController){
        
        addChildViewController(viewController)
        viewController.view.frame = view.bounds
        //self.view.addSubview(viewController.view)
        UIView.transition(with: self.view,duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,animations:  {self.view.addSubview(viewController.view)}, completion:  nil)
        
        
    }
    //MARK: Hide VC
    func HideViewController(viewController :PauseGameViewController){
        viewController.willMove(toParentViewController: nil)
        viewController.removeFromParentViewController()
        //viewController.view.removeFromSuperview()
        UIView.transition(with: self.view,duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,animations:  {viewController.view.removeFromSuperview()}, completion:  nil)
    }
    
    @IBAction func PauseGameClick(_ sender: UIButton) {
        print("pause game click")
        SceneGame.pauseButtonPressed(sender: sender)
        ShowViewController(viewController: pauseGameViewController)
     // present(pauseGameViewController, animated: true, completion: nil)
    }
    //MARK: Pause
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, . portraitUpsideDown]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    func UpdateLabel(){
        if ConstantGame.modeGame == .Classic{
            targetLabel.text=String(format: "%ld",level.targetScore)
            scoreLabel.text=String(format:"%ld",score)
        }
        else if ConstantGame.modeGame == .Limit{
            moveLabel.text=String(format: "%ld", move)
            targetLabel.text=String(format: "%ld",level.targetScore)
            scoreLabel.text=String(format:"%ld",score)
        }
        else if ConstantGame.modeGame == .Time{
             scoreLabel.text=String(format:"%ld",score)
             targetLabel.text=String(format: "%ld",level.targetScore)
             timeLabel.text = String(seconds)
        }
        
       
        
    }
    func CalculateScorePlayer(for chains: Set<Chain>){
        for chain in chains{
            self.score += chain.score
            
        }
        print(self.score)
        self.UpdateLabel()
    }
    // Ham de giam luot gi chuyen : dung cho che do limit moves
    func decrementMove(){
        move -= 1
        UpdateLabel()
    }
    // Ham check trang thai game
    func CheckGame(){
        if ConstantGame.modeGame == .Classic{
            if score >= level.targetScore{
                print("Level complete")
                PanelGameOver.image = UIImage(named: "levelcompletePanel")
                showGameOver()
            }
        }
        else if ConstantGame.modeGame == .Limit{
            decrementMove()
            if score >= level.targetScore{
                PanelGameOver.image = UIImage(named: "levelcompletePanel")
                showGameOver()
              
            }
            else if move == 0{
                loseGame = true
                PanelGameOver.image = UIImage(named: "gameoverPanel")
                showGameOver()
            }
            
        }
        else if ConstantGame.modeGame == .Target{
            if score >= level.targetScore{
                PanelGameOver.image = UIImage(named: "levelcompletePanel")
                showGameOver()
                
            }
        }
        else if ConstantGame.modeGame == .Time{
            if score >= level.targetScore{
                PanelGameOver.image = UIImage(named: "levelcompletePanel")
                showGameOver()
                
            }
        }
      
        
    }
    // cai dat cac item cho nguoi choi
    func SetNumberItem(){
        item1NumberLabel.text = String(ConstantGame.item1Number)
        item2NumberLabel.text =  String(ConstantGame.item2Number)
        item3NumberLabel.text =  String(ConstantGame.item3Number)
        item4NumberLabel.text =  String(ConstantGame.item4Number)
    }
    // them item qua moi level
    func AddNumberItem(){
        ConstantGame.item1Number = ConstantGame.item1Number+1
        ConstantGame.item2Number = ConstantGame.item2Number+1
        ConstantGame.item3Number = ConstantGame.item3Number+1
        ConstantGame.item4Number = ConstantGame.item4Number+2
    }
    
    func NextLevelGame(levelGame:Int,mode:ModeGame){
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        SceneGame = MainGameScene(size: skView.bounds.size)
        SceneGame.scaleMode = .aspectFill
        
        level = Level(filename: "Level\(levelGame)\(mode.NameMode)",modeGame: ConstantGame.modeGame)
        SceneGame.level = level
        
        SceneGame.swipeHandler = handleSwipe(_:)
        
        PanelGameOver.isHidden = true
        
        skView.presentScene(SceneGame)
        
        BeginGame()
    }
}
extension GameViewController:PauseVCDelegate{
    func playAgainViewControllerPlayButton(_viewController: PauseGameViewController) {
        let notificationGame = UIAlertController(title: "Notifications", message: "Do you want to play again", preferredStyle: .alert)
        
        notificationGame.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.SceneGame.UnPauseGame()
            self.HideViewController(viewController: self.pauseGameViewController)
            self.BeginGame()
            
            
        }))
        notificationGame.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil ))
        self.present(notificationGame, animated: true, completion: nil)
    }
    
    func pauseViewControllerPlayButton(_viewController: PauseGameViewController) {
        SceneGame.UnPauseGame()
        HideViewController(viewController: pauseGameViewController)
    }

    
    
}


