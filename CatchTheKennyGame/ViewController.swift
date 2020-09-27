//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Fatih KURT on 26.09.2020.
//

import UIKit

class ViewController: UIViewController {
    //Veriables
    var score = 0
    var timer=Timer()
    var counter=0
    var kennyArray=[UIImageView]()
    var hideTimer=Timer()
    var highscore=0
    
   //imageView
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var socreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socreLabel.text = "Score : \(score)"
        //HighScore
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore==nil{
            highscore=0
            highScoreLabel.text="HighScore: \(self.highscore)"
        }
        if let newScore=storedHighScore as? Int{
            highscore=newScore
            highScoreLabel.text="HighScore: \(self.highscore)"
        }
        
        //İmageView for Clicked
        kenny1.isUserInteractionEnabled=true
        kenny2.isUserInteractionEnabled=true
        kenny3.isUserInteractionEnabled=true
        kenny4.isUserInteractionEnabled=true
        kenny5.isUserInteractionEnabled=true
        kenny6.isUserInteractionEnabled=true
        kenny7.isUserInteractionEnabled=true
        kenny8.isUserInteractionEnabled=true
        kenny9.isUserInteractionEnabled=true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(scoreTimer))

        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)

        counter=10
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        kennyArray=[kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        hideKenny()
    }
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden=true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden=false
    }
    
    @objc func scoreTimer(){
        score += 1
        socreLabel.text="Score : \(score)"
        
    }
   
    @objc func timeFunction(){
        
        counter-=1
        timeLabel.text = "\(counter)"
        if counter==0{
            timer.invalidate()
            hideTimer.invalidate()
            for kenny in kennyArray{
                kenny.isHidden=true
            }
            
            if self.highscore<self.score {
                self.highscore=self.score
                self.highScoreLabel.text="HighScore : \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
                
            }
            let alert = UIAlertController(title: "Time's Up", message: "Do You Want To Play Again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            let ReplayButton=UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score=0
                self.socreLabel.text="Score: \(self.score)"
                
                self.counter=10
                self.timeLabel.text="\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
              
            }
            alert.addAction(ReplayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    
    }
    
}

