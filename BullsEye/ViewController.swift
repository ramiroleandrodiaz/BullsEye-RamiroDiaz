//
//  ViewController.swift
//  BullsEye
//
//  Created by Ramiro Diaz on 22/07/2018.
//  Copyright © 2018 ardi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sliderValue = 0
    var targetValue = 0
    var scoreValue = 0
    var roundValue = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue = lroundf(slider.value)
        self.startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func startNewRound(){
        roundValue += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        sliderValue = 50
        slider.value = Float(sliderValue)
        self.updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(scoreValue)
        roundLabel.text = String(roundValue)
    }

    @IBAction func sliderMoved(_ slider : UISlider){
        sliderValue = lroundf(slider.value)
    }

    @IBAction func showAlert(){

        let difference = abs(targetValue - sliderValue)
        var points = 100 - difference
        scoreValue += points
        let title: String
        if difference == 0{
            points += 100
            title = "Increíble!"
        }else if difference < 5 {
            title = "Casi Casi!"
            if difference == 1{
                points += 51
            }
        }else if difference < 10 {
            title = "Bastante Bien!"
        }else{
            title = "Bastante Choto..."
        }
        let message = "Le pegaste al \(sliderValue)! \nSumaste \(points) puntos"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Nice!", style: .default, handler: {
            action in
                self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func startOver(){
        scoreValue = 0
        roundValue = 0
        self.startNewRound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

