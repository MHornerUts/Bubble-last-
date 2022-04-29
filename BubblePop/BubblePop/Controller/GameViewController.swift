//
//  GameViewController.swift
//  BubblePop
//
//  Created by Matthew Horner on 27/4/2022.
//

import Foundation
import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var name:String?
    var timer = Timer()
    var time = 60
    var count = 0
    var maxBubbles = 15
    var currentBubbles = 0
    var bubbleArray: [Bubble] = []
    var lastBubblePressed = ""
    var bubbleTimer = Timer()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLable.text = name
        timeLabel.text = String(time)
        scoreLabel.text = String(count)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        bubbleTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(bubbleTimerAction), userInfo: nil, repeats: true)
        
    }
    
    
    
    @objc func timerAction(){
        if (time > 0) {
            time = time - 1
            timeLabel.text = String(time)
            
        } else {
            timer.invalidate()
            bubbleTimer.invalidate()
            let vc = storyboard?.instantiateViewController(identifier:"ScoreViewController") as! ScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
            vc.writeHighScores(name: name ?? "Unnamed", score: count)
            
        }
        
    
    }
    
    @objc func bubbleTimerAction(){
            
        let currentMaxBubbles = Int.random(in: 1...maxBubbles)
        
        if (bubbleArray.isEmpty) {
            
            for _ in 0..<currentMaxBubbles {
                self.createBubble()
            }
            
        } else {
            var tempBubbleArray: [Bubble] = []
            for x in bubbleArray {
                let remove = Int.random(in: 1...100)
                
                if (remove > 50) {
                    x.removeFromSuperview()
                    currentBubbles = currentBubbles - 1
                } else {
                    tempBubbleArray.append(x)
                }
            }
            bubbleArray.removeAll()
            
            bubbleArray = tempBubbleArray
            
            for _ in 0..<currentMaxBubbles {
                self.createBubble()
            }
            
        }
    }
    
    @objc func createBubble() {
        
        let bubble = Bubble()
        var useable = true
      
        if !bubbleArray.isEmpty {
            for x in bubbleArray {
                if bubble.frame.intersects(x.frame) {
                    useable = false
                }
            }
        }
    
        
        if useable && currentBubbles < maxBubbles {
            bubbleArray.append(bubble)
            
            bubble.animation()
            
            switch bubble.getColorString() {
            case "pink":
                bubble.addTarget(self, action: #selector(pinkBubblePressed), for: .touchUpInside)
            case "green":
                bubble.addTarget(self, action: #selector(greenBubblePressed), for: .touchUpInside)
            case "blue":
                bubble.addTarget(self, action: #selector(blueBubblePressed), for: .touchUpInside)
            case "black":
                bubble.addTarget(self, action: #selector(blackBubblePressed), for: .touchUpInside)
            default:
                bubble.addTarget(self, action: #selector(redBubblePressed), for: .touchUpInside)
            }
            
            currentBubbles = currentBubbles + 1
            self.view.addSubview(bubble)
        }
        
    }
    
    func updateCount(str: String) {
        var amount = 1.0
        
        switch str {
        case "pink":
            amount = 2.0
        case "green":
            amount = 5.0
        case "blue":
            amount = 8.0
        case "black":
            amount = 10.0
        default:
            amount = 1.0
        }
        
        var combo = amount * 1.5
        combo.round()
        
        if lastBubblePressed == str {
            count = count + Int(combo)
                
        } else {
            count = count + Int(amount)
            lastBubblePressed = str
        }
        
     
        
    }
    
    @IBAction func redBubblePressed(_ sender: UIButton) {
        sender.removeFromSuperview()
        updateCount(str: "red")
        
        currentBubbles = currentBubbles - 1
        scoreLabel.text = String(count)
    }
    
    
    @IBAction func pinkBubblePressed(_ sender: UIButton) {
        sender.removeFromSuperview()
        
        updateCount(str: "pink")
        scoreLabel.text = String(count)
        currentBubbles = currentBubbles - 1
        
    }
    
    
    @IBAction func greenBubblePressed(_ sender: UIButton) {
        sender.removeFromSuperview()
        
        updateCount(str: "green")
        scoreLabel.text = String(count)
        currentBubbles = currentBubbles - 1
        
    }
    
    
    @IBAction func blueBubblePressed(_ sender: UIButton) {
        sender.removeFromSuperview()
        updateCount(str: "blue")
        scoreLabel.text = String(count)
        currentBubbles = currentBubbles - 1
        
    }
    
    
    @IBAction func blackBubblePressed(_ sender: UIButton) {
        sender.removeFromSuperview()
        updateCount(str: "black")
        scoreLabel.text = String(count)
        currentBubbles = currentBubbles - 1
        
    }
    
    
}
