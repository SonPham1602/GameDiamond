//
//  MainMenuGameViewController.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 1/2/19.
//  Copyright © 2019 SonPham. All rights reserved.
//

import UIKit
import SpriteKit
class MainMenuGameViewController: UIViewController {
    
    
     var settingViewController:SettingGameViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingViewController = storyboard?.instantiateViewController(withIdentifier: "ID_SettingViewController") as? SettingGameViewController
        settingViewController.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Show VC
    func ShowSettingViewController(viewController: SettingGameViewController){
        
        addChildViewController(viewController)
        viewController.view.frame = view.bounds
        //self.view.addSubview(viewController.view)
        UIView.transition(with: self.view,duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,animations:  {self.view.addSubview(viewController.view)}, completion:  nil)
        
        
    }
    func HideSettingViewController(viewController :SettingGameViewController){
        viewController.willMove(toParentViewController: nil)
        // viewController.removeFromParentViewController()
        //viewController.view.removeFromSuperview()
        UIView.transition(with: self.view,duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve,animations:  {viewController.view.removeFromSuperview()}, completion:  nil)
    }
    @IBAction func SettingGameClick(_ sender: UIButton) {
        ShowSettingViewController(viewController: settingViewController)
    }
    @IBAction func PlayGameClick(_ sender: UIButton) {

        
    }
    @IBAction func BestScoreGameClick(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
extension MainMenuGameViewController:SettingVCDelegate{
    func closeSetting(_viewController: SettingGameViewController) {
        HideSettingViewController(viewController: settingViewController)
    }
    
    
}
