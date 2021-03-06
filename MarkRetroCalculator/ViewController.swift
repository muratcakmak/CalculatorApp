//
//  ViewController.swift
//  MarkRetroCalculator
//
//  Created by muratcakmak on 22/10/15.
//  Copyright © 2015 Murat Cakmak. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var outLabel: UILabel!
    
    @IBAction func clearEverything(sender: AnyObject) {
        leftOperand = ""
        rightOperand = ""
        result = ""
        operation = 0
        currentOperand = ""
        outLabel.text = ""

        
    }
    var btnSound: AVAudioPlayer!
    
    var leftOperand: String = ""
    var rightOperand: String = ""
    var result: String = ""
    var operation: Int = 0
    var currentOperand: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        outLabel.text = ""
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        
    }

    @IBAction func numberPressed(btn: UIButton!){
        soundPlay()
        if btn.tag > 9 {
            if operation != 0  && rightOperand == "" && leftOperand != "" {
                rightOperand = currentOperand
                if operation == 10 {
                    result = String(Double(leftOperand)! / Double(rightOperand)!)
                    updateValues(btn.tag)
                }
                else if operation == 11 {
                    result = String(Double(leftOperand)! * Double(rightOperand)!)
                    updateValues(btn.tag)
                }
                else if operation == 12 {
                    result = String(Double(leftOperand)! - Double(rightOperand)!)
                    updateValues(btn.tag)
                }
                else if operation == 13 {
                    result = String(Double(leftOperand)! + Double(rightOperand)!)
                    updateValues(btn.tag)
                }
                else if operation == 14 {
                    leftOperand = currentOperand
                    rightOperand = ""
                    operation = 0
                }
                
                
            }
                
            else{
                if btn.tag > 9 {
                    operation = btn.tag
                }
                leftOperand = currentOperand
                rightOperand = ""

            }
            
            
        }else{
            if currentOperand == leftOperand{
                currentOperand = ""
            }
                currentOperand += String(btn.tag)
                outLabel.text = currentOperand
        }
        
    }
    
    func soundPlay(){
        if btnSound.playing{
            btnSound.stop()
        }
            btnSound.play()
        
    
    }
    func updateValues(tag: Int){
        currentOperand = result
        outLabel.text = currentOperand
        rightOperand = ""
        leftOperand = currentOperand
        operation = tag
    
    }

}

