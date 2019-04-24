//
//  PauseGameViewController.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 1/1/19.
//  Copyright © 2019 SonPham. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
protocol PauseVCDelegate{
    func pauseViewControllerPlayButton(_viewController:PauseGameViewController)
    func playAgainViewControllerPlayButton(_viewController:PauseGameViewController)
}
class PauseGameViewController: UIViewController {

    var delegate:PauseVCDelegate!
   
    var settingViewController:SettingGameViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingViewController = storyboard?.instantiateViewController(withIdentifier: "ID_SettingViewController") as? SettingGameViewController
        settingViewController.delegate = self
//        if let view = self.view as! SKView?{
//            view.isMultipleTouchEnabled=false
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    //MARK: Show VC
    func ShowViewController(viewController: SettingGameViewController){
        
        addChildViewController(viewController)
        viewController.view.frame = view.bounds
        //self.view.addSubview(viewController.view)
        UIView.transition(with: self.view,duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,animations:  {self.view.addSubview(viewController.view)}, completion:  nil)
        
        
    }
    func HideViewController(viewController :SettingGameViewController){
        viewController.willMove(toParentViewController: nil)
       // viewController.removeFromParentViewController()
        //viewController.view.removeFromSuperview()
        UIView.transition(with: self.view,duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,animations:  {viewController.view.removeFromSuperview()}, completion:  nil)
    }
    @IBAction func CloseMenuClick(_ sender: UIButton) {
        delegate.pauseViewControllerPlayButton(_viewController: self)
    }
    
    @IBAction func SettingMenuClick(_ sender: UIButton) {
        ShowViewController(viewController: settingViewController)
        
    }
    @IBAction func PlayAgainClick(_ sender: UIButton) {
        delegate.playAgainViewControllerPlayButton(_viewController: self)
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
extension PauseGameViewController:SettingVCDelegate{
    func closeSetting(_viewController: SettingGameViewController) {
        HideViewController(viewController: settingViewController)
    }
    
    
}
