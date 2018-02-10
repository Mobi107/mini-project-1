//
//  ViewController2.swift
//  Mini Project 1
//
//  Created by Mudabbir Khan on 2/9/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var resumeButton: UIButton!
    var lastThreeNames: [String] = []
    var lastThreeCorrect: [String] = []
    var streak: Int = 0
    var streakLabel: UILabel!
    var resultTitle: UILabel!
    var correctTitle: UILabel!
    var answerTitle: UILabel!
    var firstCorrect: UILabel!
    var secondCorrect: UILabel!
    var thirdCorrect: UILabel!
    var firstAnswer: UILabel!
    var secondAnswer: UILabel!
    var thirdAnswer: UILabel!
    var pics: [UIImage] = []
    var pic1: UIImageView!
    var pic2: UIImageView!
    var pic3: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 0.40, green: 0.70, blue: 1.0, alpha: 1.0)
        setResumeButton()
        setStreakLabel()
        setResultTitleLabel()
        setCorrectTitleLabel()
        setAnswerTitleLabel()
        setFirstCorrect()
        setSecondCorrect()
        setThirdCorrect()
        setFirstAnswer()
        setSecondAnswer()
        setThirdAnswer()
        setPics()
        // Do any additional setup after loading the view.
    }
    
    func setResumeButton() {
        resumeButton = UIButton(frame: CGRect(x: 20, y: 50, width: view.frame.width - 280, height: 50))
        resumeButton.backgroundColor = UIColor.init(red: 0.00, green: 0.40, blue: 0.80, alpha: 1.0)
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.setTitleColor(.white, for: .normal)
        resumeButton.layer.cornerRadius = 5
        resumeButton.layer.borderWidth = 2
        resumeButton.layer.borderColor = UIColor.black.cgColor
        resumeButton.addTarget(self, action: #selector(changeResumeButton), for: .touchUpInside)
        resumeButton.isHidden = false
        view.addSubview(resumeButton)
    }
    
    @objc func changeResumeButton() {
        resumeButton.backgroundColor = UIColor.init(red: 0.00, green: 0.40, blue: 0.80, alpha: 0.7)
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(resumeButtonTapped), userInfo: nil, repeats: false)
    }
    
    @objc func resumeButtonTapped() {
        resumeButton.backgroundColor = UIColor.init(red: 0.00, green: 0.40, blue: 0.80, alpha: 0.7)
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(goToGame), userInfo: nil, repeats: false)
    }
    
    @objc func goToGame() {
        self.performSegue(withIdentifier: "gameSegue", sender: "resumeButtonTapped")
    }
    
    func setPics() {
        pic1 = UIImageView(frame: CGRect(x: 20, y: 330, width: 55, height: 55))
        pic2 = UIImageView(frame: CGRect(x: 20, y: 400, width: 55, height: 55))
        pic3 = UIImageView(frame: CGRect(x: 20, y: 470, width: 55, height: 55))
        pic1.layer.cornerRadius = 5
        pic1.layer.borderWidth = 1
        pic1.layer.borderColor = UIColor.black.cgColor
        pic2.layer.cornerRadius = 5
        pic2.layer.borderWidth = 1
        pic2.layer.borderColor = UIColor.black.cgColor
        pic3.layer.cornerRadius = 5
        pic3.layer.borderWidth = 1
        pic3.layer.borderColor = UIColor.black.cgColor
        pic1.image = pics[2]
        pic2.image = pics[1]
        pic3.image = pics[0]
        view.addSubview(pic1)
        view.addSubview(pic2)
        view.addSubview(pic3)
    }
    
    func setStreakLabel() {
        streakLabel = UILabel(frame: CGRect(x: 70, y: 140, width: view.frame.width - 150, height: 50))
        streakLabel.font = UIFont.boldSystemFont(ofSize: 20)
        streakLabel.text = "Longest streak: \(streak)"
        streakLabel.textColor = .white
        streakLabel.textAlignment = .center
        streakLabel.isHidden = false
        view.addSubview(streakLabel)
    }
    
    func setResultTitleLabel() {
        resultTitle = UILabel(frame: CGRect(x: 70, y: 210, width: view.frame.width - 150, height: 50))
        resultTitle.font = UIFont.boldSystemFont(ofSize: 20)
        resultTitle.attributedText = NSAttributedString(string: "Last three results", attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        resultTitle.textColor = .white
        resultTitle.textAlignment = .center
        resultTitle.isHidden = false
        view.addSubview(resultTitle)
    }
    
    func setCorrectTitleLabel() {
        correctTitle = UILabel(frame: CGRect(x: 30, y: 260, width: view.frame.width - 150, height: 50))
        correctTitle.font = UIFont.boldSystemFont(ofSize: 20)
        correctTitle.text = "Correct Answer"
        correctTitle.textColor = .white
        correctTitle.textAlignment = .center
        correctTitle.isHidden = false
        view.addSubview(correctTitle)
    }
    
    func setAnswerTitleLabel() {
        answerTitle = UILabel(frame: CGRect(x: 180, y: 260, width: view.frame.width - 150, height: 50))
        answerTitle.font = UIFont.boldSystemFont(ofSize: 20)
        answerTitle.text = "Your Answer"
        answerTitle.textColor = .white
        answerTitle.textAlignment = .center
        answerTitle.isHidden = false
        view.addSubview(answerTitle)
    }
    
    func setFirstCorrect() {
        firstCorrect = UILabel(frame: CGRect(x: 30, y: 330, width: view.frame.width - 150, height: 50))
        firstCorrect.font = UIFont.boldSystemFont(ofSize: 15)
        firstCorrect.text = "\(lastThreeCorrect[2])"
        firstCorrect.textColor = .white
        firstCorrect.textAlignment = .center
        firstCorrect.isHidden = false
        view.addSubview(firstCorrect)
    }
    
    func setSecondCorrect() {
        secondCorrect = UILabel(frame: CGRect(x: 30, y: 400, width: view.frame.width - 150, height: 50))
        secondCorrect.font = UIFont.boldSystemFont(ofSize: 15)
        secondCorrect.text = "\(lastThreeCorrect[1])"
        secondCorrect.textColor = .white
        secondCorrect.textAlignment = .center
        secondCorrect.isHidden = false
        view.addSubview(secondCorrect)
    }
    
    func setThirdCorrect() {
        thirdCorrect = UILabel(frame: CGRect(x: 30, y: 470, width: view.frame.width - 150, height: 50))
        thirdCorrect.font = UIFont.boldSystemFont(ofSize: 15)
        thirdCorrect.text = "\(lastThreeCorrect[0])"
        thirdCorrect.textColor = .white
        thirdCorrect.textAlignment = .center
        thirdCorrect.isHidden = false
        view.addSubview(thirdCorrect)
    }
    
    func setFirstAnswer() {
        firstAnswer = UILabel(frame: CGRect(x: 180, y: 330, width: view.frame.width - 150, height: 50))
        firstAnswer.font = UIFont.boldSystemFont(ofSize: 15)
        firstAnswer.text = "\(lastThreeNames[2])"
        if (firstAnswer.text == "-") {
            firstAnswer.textColor = .white
        } else if (firstCorrect.text?.elementsEqual(firstAnswer.text!))! {
            firstAnswer.textColor = .green
        } else {
            firstAnswer.textColor = .red
        }
        firstAnswer.textAlignment = .center
        firstAnswer.isHidden = false
        view.addSubview(firstAnswer)
    }
    
    func setSecondAnswer() {
        secondAnswer = UILabel(frame: CGRect(x: 180, y: 400, width: view.frame.width - 150, height: 50))
        secondAnswer.font = UIFont.boldSystemFont(ofSize: 15)
        secondAnswer.text = "\(lastThreeNames[1])"
        if (secondAnswer.text == "-") {
            secondAnswer.textColor = .white
        } else if (secondCorrect.text?.elementsEqual(secondAnswer.text!))! {
            secondAnswer.textColor = .green
        } else {
            secondAnswer.textColor = .red
        }
        secondAnswer.textAlignment = .center
        secondAnswer.isHidden = false
        view.addSubview(secondAnswer)
    }
    
    func setThirdAnswer() {
        thirdAnswer = UILabel(frame: CGRect(x: 180, y: 470, width: view.frame.width - 150, height: 50))
        thirdAnswer.font = UIFont.boldSystemFont(ofSize: 15)
        thirdAnswer.text = "\(lastThreeNames[0])"
        if (thirdAnswer.text == "-") {
            thirdAnswer.textColor = .white
        } else if (thirdCorrect.text?.elementsEqual(thirdAnswer.text!))! {
            thirdAnswer.textColor = .green
        } else {
            thirdAnswer.textColor = .red
        }
        thirdAnswer.textAlignment = .center
        thirdAnswer.isHidden = false
        view.addSubview(thirdAnswer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameSegue" {
            _ = segue.destination as! ViewController
        }
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
