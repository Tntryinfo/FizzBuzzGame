//
//  StartViewController.swift
//  FizzBuzz
//
//  Created by TakumaNishioka on 2018/06/13.
//  Copyright © 2018年 TakumaNishioka. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // 問題の作成
        QuestionDataManager.sharedInstance.makeQuestion()
        // 遷移画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            //取得失敗終了
            return
        }
        // 問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 取得失敗
            return
        }
        
        nextViewController.questionData = questionData
    }
    
    //　タイトルに戻ってくるときに呼び出される処理
    @IBAction func goToTitle(_ segue: UIStoryboardSegue){
        
    }
}
