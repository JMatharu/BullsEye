//
//  ViewController.swift
//  BullsEye
//
//  Created by Jagdeep Matharu on 2017-01-26.
//  Copyright © 2017 Jagdeep Matharu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background Image
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        //Slider UI
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")//UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")//UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")//UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")//UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewRound()
        scoreLabel.text = "Score : 0"
        roundLabel.text = "Round : \(round)"
    }
    
    @IBAction func showAlert(){
        let difference = abs(currentValue - targetValue)
        var point = 100 - difference
        var title: String = "";
        
        //Score
        score += point
        
        //Round
        round += 1
        
        //Notification Message string
        if difference == 0 {
            title = "Perfect\nYou got 100 bonus points"
            point += 100
        }else if (difference <= 5 && difference > 1) {
            title = "You almost had it!"
        }else if (difference == 1) {
            title = "You almost had it!\nYou got 50 bonus points"
            point += 50
        }else if (difference <= 10){
            title = "Pretty good!"
        }else {
            title = "Not even close..."
        }
        
        //        let messageDebug: String = "The Value of Slider is : \(currentValue)" +
        //                              "\nThe Target value is : \(targetValue)" +
        //                              "\nThe Difference is : \(difference)" +
        //                              "\nYou Scored \(point) points"
        let message: String = "You Scored \(point) points"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
            self.updateLabels()
        });
        alert.addAction(action);
        present(alert, animated: true, completion: nil);
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
//        print("The Value of slider is : \(slider.value)")
        currentValue = Int(slider.value)
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        scoreLabel.text = "Score : 0"
        score = 0
        roundLabel.text = "Round : 1"
        round = 1
        slider.value = 50
        startNewRound()
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = "Put the Bull's eye as close as you can to : \(targetValue)"
        scoreLabel.text = "Score : \(score)"
        roundLabel.text = "Round : \(round)"
    }
}

