//
//  ViewController.swift
//  Mini Project 1
//
//  Created by Mudabbir Khan on 2/7/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startButton: UIButton!
    var stopButton: UIButton!
    var scoreLabel: UILabel!
    var timeLabel: UILabel!
    var score: Int = 0
    var statsButton: UIButton!
    var backToGameButton: UIButton!
    var imageView : UIImageView!
//    var logo: UIImageView!
    var memberPicture: UIImageView!
    var optionOne: UIButton!
    var optionTwo: UIButton!
    var optionThree: UIButton!
    var optionFour: UIButton!
    var options: [UIButton] = []
    var name: String!
    var pics: [UIImage] = [#imageLiteral(resourceName: "blue"), #imageLiteral(resourceName: "blue"), #imageLiteral(resourceName: "blue")]
    var memberImages: [String] = []
    var memberNames: [String] = []
    var memberPics: [UIImage] = []
    var buttonTimer = Timer()
    var normalTimer = Timer()
    var gameTimer = Timer()
    var endLabel: UILabel!
    let winScore: Int = 54
    var buttonClick: Bool!
    var lastThree: [String] = ["-", "-", "-"]
    var threeCorrect: [String] = ["-", "-", "-"]
    var streak: Int = 0
    var answer: String!
    var time: Int = 5
    var randomIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setStartButton()
        setStopButton()
        setStatsButton()
        setScore()
        setTimer()
        setPicture()
        setNames()
        setEnd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setStartButton() {
        startButton = UIButton(frame: CGRect(x: 50, y: 450, width: view.frame.width - 100, height: 50))
        updateStartButton()
    }
    
    func setStatsButton() {
        statsButton = UIButton(frame: CGRect(x: 250, y: 50, width: view.frame.width - 280, height: 50))
        hideStatsButton()
    }
    
    @objc func updateStartButton() {
        let background = UIImage(named: "MDB pic")
        imageView = UIImageView(frame: view.frame)
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
//        logo = UIImageView(frame: CGRect(x: 20, y: 130, width: view.frame.width - 40, height: 320))
//        logo.image = UIImage(named: "MDB image")
        arrayImages()
        arrayNames()
        arrayPics()
        score = 0
        startButton.backgroundColor = UIColor.init(red: 0.19, green: 0.57, blue: 0.82, alpha: 1.0)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.isHidden = false
        imageView.isHidden = false
//        logo.isHidden = false
        view.addSubview(startButton)
//        view.addSubview(logo)
    }
    
    func updateStatsButton() {
        statsButton.backgroundColor = UIColor.init(red: 0.00, green: 0.40, blue: 0.80, alpha: 1.0)
        statsButton.setTitle("Stats", for: .normal)
        statsButton.setTitleColor(.white, for: .normal)
        statsButton.layer.cornerRadius = 5
        statsButton.layer.borderWidth = 2
        statsButton.layer.borderColor = UIColor.black.cgColor
        statsButton.addTarget(self, action: #selector(statsButtonTapped), for: .touchUpInside)
        statsButton.isHidden = false
        view.addSubview(statsButton)
    }
    
    @objc func startButtonTapped(sender: UIButton) {
        startButton.backgroundColor = UIColor.init(red: 0.19, green: 0.57, blue: 0.82, alpha: 0.8)
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
    }
    
    @objc func statsButtonTapped(sender: UIButton) {
        statsButton.backgroundColor = UIColor.init(red: 0.00, green: 0.40, blue: 0.80, alpha: 0.7)
        gameTimer.invalidate()
        normalTimer.invalidate()
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(goToStats), userInfo: nil, repeats: false)
    }
    
    @objc func goToStats() {
        self.performSegue(withIdentifier: "statsSegue", sender: "statsButtonTapped")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statsSegue" {
            let newVC = segue.destination as! ViewController2
            newVC.lastThreeNames = lastThree
            newVC.lastThreeCorrect = threeCorrect
            newVC.streak = streak
            newVC.pics = pics
        }
    }
    
    @objc func playGame() {
        self.view.backgroundColor = UIColor.init(red: 0.40, green: 0.70, blue: 1.0, alpha: 1.0)
        if (memberImages.count == 0) {
            endGame()
        } else {
            buttonClick = true
            time = 5
            hideStartButton()
            hideBack()
            updateStopButton()
            updateStatsButton()
            updateScoreLabel()
            updateTimeLabel()
            updatePicture()
            updateNames()
            normalTimer.invalidate()
            gameTimer.invalidate()
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTime), userInfo: nil, repeats: true)
            normalTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(correctOption2), userInfo: nil, repeats: true)
        }
//        normalTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        
    }
    
    @objc func changeTime() {
        time -= 1
        updateTimeLabel()
    }
    
    func setStopButton() {
        stopButton = UIButton(frame: CGRect(x: 20, y: 50, width: view.frame.width - 280, height: 50))
        hideStopButton()
    }
    
    func updateStopButton() {
        stopButton.backgroundColor = UIColor.init(red: 0.00, green: 0.40, blue: 0.80, alpha: 1.0)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(.white, for: .normal)
        stopButton.layer.cornerRadius = 5
        stopButton.layer.borderWidth = 2
        stopButton.layer.borderColor = UIColor.black.cgColor
        stopButton.addTarget(self, action: #selector(changeStopButton), for: .touchUpInside)
        stopButton.isHidden = false
        view.addSubview(stopButton)
    }
    
    func setScore() {
        scoreLabel = UILabel(frame: CGRect(x: 90, y: 50, width: view.frame.width - 200, height: 50))
//        scoreLabel.font = UIFont.init(name: scoreLabel.font.fontName, size: 50.0)
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        scoreLabel.font = UIFont.italicSystemFont(ofSize: 15)
        hideScore()
    }
    
    func setTimer() {
        timeLabel = UILabel(frame: CGRect(x: 90, y: 600, width: view.frame.width - 200, height: 50))
        timeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        hideTimer()
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        scoreLabel.isHidden = false
        view.addSubview(scoreLabel)
    }
    
    func updateTimeLabel() {
        if (time < 0) {
            return
        }
        timeLabel.text = "Time: \(time)"
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        timeLabel.isHidden = false
        view.addSubview(timeLabel)
    }
    
    func updatePicture() {
        if (memberImages.count) == 0 {
            endGame()
        } else {
            memberPicture.layer.cornerRadius = 5
            memberPicture.layer.borderWidth = 2
            memberPicture.layer.borderColor = UIColor.black.cgColor
            randomIndex = Int(arc4random_uniform(UInt32(memberImages.count)))
            name = "\(memberImages[randomIndex])"
            memberPicture.image = UIImage(named: "\(memberImages[randomIndex])")
            memberImages.remove(at: randomIndex)
            memberPicture.isHidden = false
            view.addSubview(memberPicture)
        }
    }
    
    func updateNames() {
        optionOne.backgroundColor = UIColor.init(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
        optionOne.setTitleColor(.black, for: .normal)
        optionOne.layer.cornerRadius = 5
        optionOne.layer.borderWidth = 2
        optionOne.layer.borderColor = UIColor.black.cgColor
        optionOne.addTarget(self, action: #selector(optionOneTapped), for: .touchUpInside)
        
        optionTwo.backgroundColor = UIColor.init(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
        optionTwo.setTitleColor(.black, for: .normal)
        optionTwo.layer.cornerRadius = 5
        optionTwo.layer.borderWidth = 2
        optionTwo.layer.borderColor = UIColor.black.cgColor
        optionTwo.addTarget(self, action: #selector(optionTwoTapped), for: .touchUpInside)
        
        optionThree.backgroundColor = UIColor.init(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
        optionThree.setTitleColor(.black, for: .normal)
        optionThree.layer.cornerRadius = 5
        optionThree.layer.borderWidth = 2
        optionThree.layer.borderColor = UIColor.black.cgColor
        optionThree.addTarget(self, action: #selector(optionThreeTapped), for: .touchUpInside)
        
        optionFour.backgroundColor = UIColor.init(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
        optionFour.setTitleColor(.black, for: .normal)
        optionFour.layer.cornerRadius = 5
        optionFour.layer.borderWidth = 2
        optionFour.layer.borderColor = UIColor.black.cgColor
        optionFour.addTarget(self, action: #selector(optionFourTapped), for: .touchUpInside)
        
        optionOne.isHidden = false
        optionTwo.isHidden = false
        optionThree.isHidden = false
        optionFour.isHidden = false
        
        options.append(optionOne)
        options.append(optionTwo)
        options.append(optionThree)
        options.append(optionFour)
        var optionNames: [String] = [name]
        while (optionNames.count != 4) {
            let randomName = memberNames[(Int(arc4random_uniform(UInt32(memberNames.count))))]
            if (!optionNames.contains(randomName)) {
                optionNames.append(randomName)
            }
        }
        var i = 0
        while (i < 4) {
            let optionIndex = (Int(arc4random_uniform(UInt32(optionNames.count))))
            options[i].setTitle(optionNames[optionIndex], for: .normal)
            optionNames.remove(at: optionIndex)
            i += 1
        }
        options.removeAll()
        view.addSubview(optionOne)
        view.addSubview(optionTwo)
        view.addSubview(optionThree)
        view.addSubview(optionFour)
    }
    
    func setPicture() {
        memberPicture = UIImageView(frame: CGRect(x: 20, y: 130, width: view.frame.width - 40, height: 320))
        hidePicture()
    }
    
    func setNames() {
        optionOne = UIButton(frame: CGRect(x: 7, y: 480, width: view.frame.width - 200, height: 50))
        optionTwo = UIButton(frame: CGRect(x: 193, y: 480, width: view.frame.width - 200, height: 50))
        optionThree = UIButton(frame: CGRect(x: 7, y: 543, width: view.frame.width - 200, height: 50))
        optionFour = UIButton(frame: CGRect(x: 193, y: 543, width: view.frame.width - 200, height: 50))
        hideOptions()
    }
    
    @objc func stopButtonTapped() {
        normalTimer.invalidate()
        gameTimer.invalidate()
        hideStopButton()
        hideStatsButton()
        hidePicture()
        hideOptions()
        hideScore()
        hideTimer()
        updateStartButton()
    }
    
    @objc func changeStopButton(sender: UIButton) {
        stopButton.backgroundColor = UIColor.init(red: 0.00, green: 0.40, blue: 0.80, alpha: 0.7)
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(stopButtonTapped), userInfo: nil, repeats: false)
    }
    
    @objc func optionOneTapped(sender: UIButton) {
        if (buttonClick == false) {
            return
        }
        gameTimer.invalidate()
        normalTimer.invalidate()
        threeCorrect.removeFirst()
        threeCorrect.append(name)
        pics.removeFirst()
        pics.append(memberPics[randomIndex])
        memberPics.remove(at: randomIndex)
        print(threeCorrect)
        if (optionOne.currentTitle == name) {
            buttonClick = false
            optionOne.backgroundColor = UIColor.init(red: 0.00, green: 0.80, blue: 0.00, alpha: 1.0)
            score += 1
            streak += 1
            lastThree.removeFirst()
            lastThree.append(name)
            buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        } else {
            buttonClick = false
            optionOne.backgroundColor = UIColor.init(red: 0.80, green: 0.00, blue: 0.00, alpha: 1.0)
            lastThree.removeFirst()
            lastThree.append(optionOne.currentTitle!)
            streak = 0
            correctOption()
            buttonTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        }
    }
    
    @objc func optionTwoTapped(sender: UIButton) {
        if (buttonClick == false) {
            return
        }
        gameTimer.invalidate()
        normalTimer.invalidate()
        threeCorrect.removeFirst()
        threeCorrect.append(name)
        pics.removeFirst()
        pics.append(memberPics[randomIndex])
        print(threeCorrect)
        if (optionTwo.currentTitle == name) {
            buttonClick = false
            optionTwo.backgroundColor = UIColor.init(red: 0.00, green: 0.80, blue: 0.00, alpha: 1.0)
            score += 1
            streak += 1
            lastThree.removeFirst()
            lastThree.append(name)
            buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        } else {
            buttonClick = false
            optionTwo.backgroundColor = UIColor.init(red: 0.80, green: 0.00, blue: 0.00, alpha: 1.0)
            lastThree.removeFirst()
            lastThree.append(optionTwo.currentTitle!)
            streak = 0
            correctOption()
            buttonTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        }
    }
    
    @objc func optionThreeTapped(sender: UIButton) {
        if (buttonClick == false) {
            return
        }
        gameTimer.invalidate()
        normalTimer.invalidate()
        threeCorrect.removeFirst()
        threeCorrect.append(name)
        pics.removeFirst()
        pics.append(memberPics[randomIndex])
        print(threeCorrect)
        if (optionThree.currentTitle == name) {
            buttonClick = false
            optionThree.backgroundColor = UIColor.init(red: 0.00, green: 0.80, blue: 0.00, alpha: 1.0)
            score += 1
            streak += 1
            lastThree.removeFirst()
            lastThree.append(name)
            buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        } else {
            buttonClick = false
            optionThree.backgroundColor = UIColor.init(red: 0.80, green: 0.00, blue: 0.00, alpha: 1.0)
            lastThree.removeFirst()
            lastThree.append(optionThree.currentTitle!)
            streak = 0
            correctOption()
            buttonTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        }
    }
    
    @objc func optionFourTapped(sender: UIButton) {
        if (buttonClick == false) {
            return
        }
        gameTimer.invalidate()
        normalTimer.invalidate()
        threeCorrect.removeFirst()
        threeCorrect.append(name)
        pics.removeFirst()
        pics.append(memberPics[randomIndex])
        print(threeCorrect)
        if (optionFour.currentTitle == name) {
            buttonClick = false
            optionFour.backgroundColor = UIColor.init(red: 0.00, green: 0.80, blue: 0.00, alpha: 1.0)
            score += 1
            streak += 1
            lastThree.removeFirst()
            lastThree.append(name)
            buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        } else {
            buttonClick = false
            optionFour.backgroundColor = UIColor.init(red: 0.80, green: 0.00, blue: 0.00, alpha: 1.0)
            lastThree.removeFirst()
            lastThree.append(optionFour.currentTitle!)
            streak = 0
            correctOption()
            buttonTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
        }
    }
    
    func correctOption() {
        if (optionOne.currentTitle == name) {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeColor1), userInfo: nil, repeats: false)
        } else if (optionTwo.currentTitle == name) {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeColor2), userInfo: nil, repeats: false)
        } else if (optionThree.currentTitle == name) {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeColor3), userInfo: nil, repeats: false)
        } else {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeColor4), userInfo: nil, repeats: false)
        }
    }
    
    @objc func correctOption2() {
        threeCorrect.removeFirst()
        threeCorrect.append(name)
        lastThree.removeFirst()
        lastThree.append("-")
        pics.removeFirst()
        pics.append(memberPics[randomIndex])
        if (optionOne.currentTitle == name) {
            optionOne.backgroundColor = UIColor.init(red: 0.96, green: 0.85, blue: 0.17, alpha: 1.0)
        } else if (optionTwo.currentTitle == name) {
            optionTwo.backgroundColor = UIColor.init(red: 0.96, green: 0.85, blue: 0.17, alpha: 1.0)
        } else if (optionThree.currentTitle == name) {
            optionThree.backgroundColor = UIColor.init(red: 0.96, green: 0.85, blue: 0.17, alpha: 1.0)
        } else {
            optionFour.backgroundColor = UIColor.init(red: 0.96, green: 0.85, blue: 0.17, alpha: 1.0)
        }
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playGame), userInfo: nil, repeats: false)
    }
    
    @objc func changeColor1() {
        optionOne.backgroundColor = UIColor.init(red: 0.96, green: 0.85, blue: 0.17, alpha: 1.0)
    }
    
    @objc func changeColor2() {
        optionTwo.backgroundColor = UIColor.init(red: 0.96, green: 0.85, blue: 0.17, alpha: 1.0)
    }
    
    @objc func changeColor3() {
        optionThree.backgroundColor = UIColor.init(red: 0.96, green: 0.85, blue: 0.17, alpha: 1.0)
    }
    
    @objc func changeColor4() {
        optionFour.backgroundColor = UIColor.init(red: 0.96, green: 0.85, blue: 0.17, alpha: 1.0)
    }
    
    func hideStartButton() {
        startButton.isHidden = true
    }
    
    func hideStopButton() {
        stopButton.isHidden = true
    }
    
    func hideStatsButton() {
        statsButton.isHidden = true
    }

    func hidePicture() {
        memberPicture.isHidden = true
    }
    
    func hideOptions() {
        optionOne.isHidden = true
        optionTwo.isHidden = true
        optionThree.isHidden = true
        optionFour.isHidden = true
    }
    
    func hideScore() {
        scoreLabel.isHidden = true
    }
    
    func hideTimer() {
        timeLabel.isHidden = true
    }
    
    func hideBack() {
        imageView.isHidden = true
    }
    
    func setEnd() {
        endLabel = UILabel(frame: CGRect(x: 20, y: 180, width: view.frame.width - 50, height: 200))
        endLabel.font = UIFont(name: endLabel.font.fontName, size: 20)
        endLabel.font = UIFont.boldSystemFont(ofSize: 20)
        endLabel.lineBreakMode = .byWordWrapping
        endLabel.numberOfLines = 0
//        endLabel.font = UIFont.italicSystemFont(ofSize: 20.0)
        endLabel.isHidden = true
    }
    
    func endGame() {
        gameTimer.invalidate()
        normalTimer.invalidate()
        hideStopButton()
        hideStatsButton()
        hidePicture()
        hideOptions()
        hideTimer()
        updateEnd()
    }
    
    func updateEnd() {
        if (score < winScore - 10) {
            endLabel.text = "You've still got to know \(winScore - score) more members. Try harder!"
        } else if (score >= winScore - 10 && score < winScore) {
            endLabel.text = "Ooh, so close! Only \(winScore - score) more members to know."
        } else {
            endLabel.text = "Woohoo, you killed it! You know everyone!"
        }
        endLabel.textColor = .white
        endLabel.textAlignment = .center
        endLabel.isHidden = false
        view.addSubview(endLabel)
    }
    
    func arrayImages() {
        memberImages = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", "Srujay Korlakunta", "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", "Jeffrey Zhang"]
    }
    
    func arrayNames() {
        memberNames = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", "Srujay Korlakunta", "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", "Jeffrey Zhang"]
    }
    
    func arrayPics() {
        memberPics = [#imageLiteral(resourceName: "Daniel Andrews"), #imageLiteral(resourceName: "Nikhar Arora"), #imageLiteral(resourceName: "Tiger Chen"), #imageLiteral(resourceName: "Xin Yi Chen"), #imageLiteral(resourceName: "Julie Deng"), #imageLiteral(resourceName: "Radhika Dhomse"), #imageLiteral(resourceName: "Kaden Dippe"), #imageLiteral(resourceName: "Angela Dong"), #imageLiteral(resourceName: "Zach Govani"), #imageLiteral(resourceName: "Shubham Gupta"), #imageLiteral(resourceName: "Suyash Gupta"), #imageLiteral(resourceName: "Joey Hejna"), #imageLiteral(resourceName: "Cody Hsieh"), #imageLiteral(resourceName: "Stephen Jayakar"), #imageLiteral(resourceName: "Aneesh Jindal"), #imageLiteral(resourceName: "Mohit Katyal"), #imageLiteral(resourceName: "Mudabbir Khan"), #imageLiteral(resourceName: "Akkshay Khoslaa"), #imageLiteral(resourceName: "Justin Kim"), #imageLiteral(resourceName: "Eric Kong"), #imageLiteral(resourceName: "Abhinav Koppu"), #imageLiteral(resourceName: "Srujay Korlakunta"), #imageLiteral(resourceName: "Ayush Kumar"), #imageLiteral(resourceName: "Shiv Kushwah"), #imageLiteral(resourceName: "Leon Kwak"), #imageLiteral(resourceName: "Sahil Lamba"), #imageLiteral(resourceName: "Young Lin"), #imageLiteral(resourceName: "William Lu"), #imageLiteral(resourceName: "Louie McConnell"), #imageLiteral(resourceName: "Max Miranda"), #imageLiteral(resourceName: "Will Oakley"), #imageLiteral(resourceName: "Noah Pepper"), #imageLiteral(resourceName: "Samanvi Rai"), #imageLiteral(resourceName: "Krishnan Rajiyah"), #imageLiteral(resourceName: "Vidya Ravikumar"), #imageLiteral(resourceName: "Shreya Reddy"), #imageLiteral(resourceName: "Amy Shen"), #imageLiteral(resourceName: "Wilbur Shi"), #imageLiteral(resourceName: "Sumukh Shivakumar"), #imageLiteral(resourceName: "Fang Shuo"), #imageLiteral(resourceName: "Japjot Singh"), #imageLiteral(resourceName: "Victor Sun"), #imageLiteral(resourceName: "Sarah Tang"), #imageLiteral(resourceName: "Kanyes Thaker"), #imageLiteral(resourceName: "Aayush Tyagi"), #imageLiteral(resourceName: "Levi Walsh"), #imageLiteral(resourceName: "Carol Wang"), #imageLiteral(resourceName: "Sharie Wang"), #imageLiteral(resourceName: "Ethan Wong"), #imageLiteral(resourceName: "Natasha Wong"), #imageLiteral(resourceName: "Aditya Yadav"), #imageLiteral(resourceName: "Candice Ye"), #imageLiteral(resourceName: "Vineeth Yeevani"), #imageLiteral(resourceName: "Jeffrey Zhang")]
    }
    
}

