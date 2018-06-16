//
//  QuestionViewController.swift
//  FizzBuzz
//
//  Created by TakumaNishioka on 2018/06/13.
//  Copyright © 2018年 TakumaNishioka. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {

    var questionData: QuestionData!
    var correctAnswerCount: Int = 0
    var timer = Timer()
    var timerflag: Bool = false
    var startTime: Double = 0.0
    
    // 何問目か表示するラベル
    @IBOutlet weak var questionNoLabel: UILabel!
    // 残り時間を表示するラベル
    @IBOutlet weak var questionRemainTime: UILabel!
    // 問題の数字を表示するラベル
    @IBOutlet weak var questionTextLabel: UILabel!
    // 正解時のイメージビュー
    @IBOutlet weak var correctImage: UIImageView!
    // 不正解時のイメージビュー
    @IBOutlet weak var IncrrectImage: UIImageView!
    // FizzButton
    @IBOutlet weak var FizzButton: UIButton!
    // BuzzButton
    @IBOutlet weak var BuzzButton: UIButton!
    //FizzBuzzButton
    @IBOutlet weak var FizzBuzzButton: UIButton!
    //NoneButton
    @IBOutlet weak var NoneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionNoLabel.text = "Q.\(QuestionDataManager.sharedInstance.nowQuestionIndex)"
        questionTextLabel.text = String(questionData.questionNum)
        // 開始した時刻の記録
        startTime = Date().timeIntervalSince1970
        // ラベルを更新
        questionRemainTime.text = "00:03"
        // 0.01秒ごとにupdateLabel()を呼び出す
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        timerflag = true
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateLabel() {
        // 経過した時間を、現在時刻-開始時刻で算出
        let elapsedTime = Date().timeIntervalSince1970 - startTime
        // 小数点以下を切り捨てる
        let flooredErapsedTime = Int(floor(elapsedTime))
        // 残り時間
        let leftTime = 3 - flooredErapsedTime
        // ラベルに表示する残り時間
        let displayString = NSString(format: "00:%02d" , leftTime) as String
        // ラベルを更新
        questionRemainTime.text = displayString
        // 残り0秒になった時点の処理
        if leftTime == 0 {
            // タイマーを止める
            timer.invalidate()
            
            //Buttonを押下できないようにする
            FizzButton.isEnabled = false
            BuzzButton.isEnabled = false
            FizzBuzzButton.isEnabled = false
            NoneButton.isEnabled = false
            // timerflagボタンが押下されていないとき
            if timerflag {
                //時間切れで次の問題に行く
                goNextQuestionWithAnimation()
            }
        }
    }
    
    // FizzButtonの処理
    @IBAction func tapAnswerFizzButton(_ sender: Any) {
        questionData.userChoiceAnswer = "Fizz"
        //タイマーを止める
        timer.invalidate()
        timerflag = false
        goNextQuestionWithAnimation()
    }
    // BuzzButtonの処理
    @IBAction func tapAnswerBuzzButton(_ sender: Any) {
        questionData.userChoiceAnswer = "Buzz"
        //タイマーを止める
        timer.invalidate()
        timerflag = false
        goNextQuestionWithAnimation()
    }
    // FizzBuzzButtonの処理
    @IBAction func tapAnswerFizzBuzzButton(_ sender: Any) {
        questionData.userChoiceAnswer = "FizzBuzz"
        //タイマーを止める
        timer.invalidate()
        timerflag = false
        goNextQuestionWithAnimation()
    }
    // NoneButtonの処理
    @IBAction func tapAnswerNoneButton(_ sender: Any) {
        questionData.userChoiceAnswer = "None"
        //タイマーを止める
        timer.invalidate()
        timerflag = false
        goNextQuestionWithAnimation()
    }
    
    // 次の問題にアニメーション付きで進む
    func goNextQuestionWithAnimation() {
        if questionData.answerCheck() {
            //正解アニメーションを再生しながら次の問題へ
            goNextQuestionWithCorrectAnimation()
        }
        else {
            //不正解アニメーションを再生しながら次の問題へ
            goNextQuestionWithInCorrectAnimation()
        }
    }
    // 正解のアニメションを再生しながら次の問題をセット
    func goNextQuestionWithCorrectAnimation() {
        // 正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1025)
        //アニメーション
        UIView.animate(withDuration: 2.0, animations :{
            //アルファ値を1.0に変化させる
            self.correctImage.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion() // アニメーション完了後に次の問題に進む
        }
    }
    // 不正解のアニメションを再生しながら次の問題をセット
    func goNextQuestionWithInCorrectAnimation() {
        AudioServicesPlayAlertSound(1006)
        
        //アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            //アルファ値を1.0に変化させる(初期値はStoryBoardで0.0に設定済み)
            self.IncrrectImage.alpha = 1.0
        }) {(Bool) in
            self.goNextQuestion()
        }
    }
    
    func goNextQuestion() {
        // 問題文の取り出し
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 問題文がない場合結果画面へ
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                present(resultViewController, animated: true,completion: nil)
            }
            return
        }
        //　次の問題がある場合
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController {
            nextQuestionViewController.questionData = nextQuestion
            // Storyboardのsegueを利用しない明示的な画面遷移処理
            present(nextQuestionViewController, animated: true,completion: nil)
            FizzButton.isEnabled = true
            BuzzButton.isEnabled = true
            FizzBuzzButton.isEnabled = true
            NoneButton.isEnabled = true
        }
    }
}
