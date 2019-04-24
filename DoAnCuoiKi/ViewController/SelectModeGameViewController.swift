//
//  SelectModeGameViewController.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 1/17/19.
//  Copyright © 2019 SonPham. All rights reserved.
//

import UIKit

class SelectModeGameViewController: UIViewController {

    var game:GameViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ClassicModeClick(_ sender: UIButton) {
        ConstantGame.modeGame = ModeGame.Classic
        game = storyboard?.instantiateViewController(withIdentifier: "GamePlay") as? GameViewController
        ShowSettingViewController(viewController: game)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func LimitModeClick(_ sender: UIButton) {
         ConstantGame.modeGame = ModeGame.Limit
        game = storyboard?.instantiateViewController(withIdentifier: "GamePlay") as? GameViewController
        
        ShowSettingViewController(viewController: game)
    }
    @IBAction func TargetModeClick(_ sender: UIButton) {
         ConstantGame.modeGame = ModeGame.Target
        game = storyboard?.instantiateViewController(withIdentifier: "GamePlay") as? GameViewController
       
        ShowSettingViewController(viewController: game)
        
    }
    @IBAction func TImeModeCick(_ sender: UIButton) {
         ConstantGame.modeGame = ModeGame.Time
        game = storyboard?.instantiateViewController(withIdentifier: "GamePlay") as? GameViewController
       
        ShowSettingViewController(viewController: game)
        
    }
    func ShowSettingViewController(viewController: GameViewController){
        
        addChildViewController(viewController)
        viewController.view.frame = view.bounds
        //self.view.addSubview(viewController.view)
        UIView.transition(with: self.view,duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,animations:  {self.view.addSubview(viewController.view)}, completion:  nil)
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
