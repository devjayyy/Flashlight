//
//  ViewController.swift
//  Flashlight
//
//  Created by 남경민 on 2022/02/06.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var flashImageView: UIImageView!
    
    var isOn = false
    var soundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSound()
            
    }
    func prepareSound() {
        let path = Bundle.main.path(forResource: "switch.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.prepareToPlay()
        } catch {
            // couldn't load file :(
        }
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }


    @IBAction func switchTapped(_ sender: Any) {
        isOn = !isOn
        
        soundPlayer?.play()
        toggleTorch(on: true)
//        if isOn == true {
//            switchButton.setImage(UIImage(named: "onSwitch"), for: .normal)
//            flashImageView.image = UIImage(named: "onBG") //imageLiteral에 대하여
//        }
//        else {
//            switchButton.setImage(UIImage(named: "offSwitch"), for: .normal)
//            flashImageView.image = UIImage(named: "offBG")
//        }
        flashImageView.image = isOn ? UIImage(named: "onBG") : UIImage(named: "offBG")
        switchButton.setImage(isOn ? UIImage(named: "onSwitch") : UIImage(named: "offSwitch"), for: .normal)
    
    }
    
}

