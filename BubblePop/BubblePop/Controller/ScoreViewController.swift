//
//  ScoreViewController.swift
//  BubblePop
//
//  Created by Matthew Horner on 27/4/2022.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController {
    

    
    struct GameScore: Codable {
        var name: String
        var score: Int
    }
    
    
    @IBOutlet weak var scoreTable: UITableView!
    
    let HIGH_SCORE_KEY = "highscore"
    
    var highScores: [GameScore] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        
        self.highScores = readHighScores()
        
        // Do any additional setup after loading the view.
    }
    
    func writeHighScores (name: String, score: Int) {
        
        let defaults = UserDefaults.standard
        
        var array = readHighScores()
        
        if array.isEmpty {
            array = [GameScore(name: name, score: score)]
        } else {
            array.append(GameScore(name: name, score: score))
        }
        
        array.sort { $0.score > $1.score }
        
        defaults.set(try? PropertyListEncoder().encode(array), forKey: HIGH_SCORE_KEY)
        
    }
    
    
    func readHighScores () -> [GameScore] {
        let defaults = UserDefaults.standard
        
        if let savedArrayData = defaults.value(forKey: HIGH_SCORE_KEY) as? Data {
            if let array = try? PropertyListDecoder().decode(Array<GameScore>.self, from: savedArrayData) {
                return array
            } else {
                return []
            }
        } else {
            return []
        }

    }
}

extension ScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        
        let scoreForThisRole = highScores[indexPath.row]
        
        cell.textLabel?.text = scoreForThisRole.name
        cell.detailTextLabel?.text = "\(scoreForThisRole.score)";
        
        return cell
    }
    
    
}
