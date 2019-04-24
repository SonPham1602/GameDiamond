//
//  SettingGameViewController.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 1/4/19.
//  Copyright © 2019 SonPham. All rights reserved.
//

import UIKit
protocol SettingVCDelegate {
   func closeSetting( _viewController:SettingGameViewController)

}
class SettingGameViewController: UIViewController {

    
    var SoundInGame: Bool!
    var MusicInGame: Bool!
    var delegate:SettingVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SoundInGame = true
        MusicInGame = true
        if SoundInGame == true{
            SoundButton.imageView?.image = UIImage(named: "soundButtonSetting")
        }
        else{
            SoundButton.imageView?.image = UIImage(named: "muteSoundButtonSetting")
        }
        
        if MusicInGame == true{
            MusicButton.imageView?.image = UIImage(named: "musicButtonSetting")
        }
        else{
            MusicButton.imageView?.image = UIImage(named: "muteMusicButtonSetting")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var SoundButton: UIButton!
    
    @IBOutlet weak var MusicButton: UIButton!
    
    
    @IBAction func SoundButtonClick(_ sender: UIButton) {
        SoundInGame = !SoundInGame
        if SoundInGame == true{
            SoundButton.imageView?.image = UIImage(named: "soundButtonSetting")
        }
        else{
            SoundButton.imageView?.image = UIImage(named: "muteSoundButtonSetting")
        }
       
    }
    
    @IBAction func AppySettingClick(_ sender: UIButton) {
        
    }
    
    @IBAction func CancelSettingClick(_ sender: UIButton) {
        delegate.closeSetting(_viewController: self)
    }
    
    @IBAction func MusicButtonClick(_ sender: UIButton) {
        MusicInGame = !MusicInGame
        if MusicInGame == true{
            MusicButton.imageView?.image = UIImage(named: "musicButtonSetting")
        }
        else{
            MusicButton.imageView?.image = UIImage(named: "muteMusicButtonSetting")
        }
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
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
