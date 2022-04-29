//
//  Bubble.swift
//  BubblePop
//
//  Created by Matthew Horner on 27/4/2022.
//

import UIKit

class Bubble: UIButton {
    
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    let randomInt = Int.random(in: 1...100)
    var x = 0
    var y = 0

    enum Color {
        case red
        case blue
        case pink
        case green
        case black
    }
    
    var color = Color.red
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setColor(number: randomInt)
        
        switch getColor() {
            case .pink:
                self.backgroundColor = .systemPink
            case .green:
                self.backgroundColor = .green
            case .blue:
                self.backgroundColor = .blue
            case .black:
                self.backgroundColor = .black
            default:
                self.backgroundColor = .red
        }
        
        x = Int.random(in: 50...Int(width)-50)
        y = Int.random(in: 50...Int(height)-110)
        
        self.frame = CGRect(x: x, y: y, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
    
    required init?(coder: NSCoder) {
        fatalError("Does something")
    }
    
    func setColor(number: Int) {
        switch number {
        case 41...70:
            color = Color.pink
        case 71...85:
            color = Color.green
        case 86...95:
            color = Color.blue
        case 96...100:
            color = Color.black
        default:
            color = Color.red
            
        }
    }
    
    func getColor() -> Color {
        return color
    }
    
    func getColorString() -> String {
        switch color {
        case .pink:
            return "pink"
        case .green:
            return "green"
        case .blue:
            return "blue"
        case .black:
            return "black"
        default:
            return "red"
        }
    }
    
    func animation() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.5
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
    
}
