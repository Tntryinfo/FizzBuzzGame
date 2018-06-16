//
//  ResultViewController.swift
//  FizzBuzz
//
//  Created by TakumaNishioka on 2018/06/15.
//  Copyright © 2018年 TakumaNishioka. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var correctPercentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var corretCount: Int = 0
        
        for questData in QuestionDataManager.sharedInstance.questionDataArray {
            if questData.answerCheck() {
                corretCount += 1
            }
        }
        
        let correctPercent: Float = (Float(corretCount)/Float(10)) * 100
        
        correctPercentLabel.text = String(format: "%.1f", correctPercent) + "%"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
