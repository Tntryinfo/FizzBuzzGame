//
//  QuestionDataManager.swift
//  FizzBuzz
//
//  Created by TakumaNishioka on 2018/06/14.
//  Copyright © 2018年 TakumaNishioka. All rights reserved.
//

import Foundation

class QuestionData {
    
    // 問題数字
    var questionNum: Int = 0
    // ユーザーの答え(noAnswerは未回答の場合の値)
    var userChoiceAnswer: String = "noAnswer"
    // 正しい答え
    var correctAnswer: String!
    // 初期化処理
    init () {
    }
    // データ作成
    func makeQustionNum() {
        questionNum = Int(arc4random_uniform(UInt32(100)))
        correctAnswer = fizzBuzzCheck()
    }
    // 正しい答えのセット
    func fizzBuzzCheck() -> String {
        if questionNum % 5 == 0 && questionNum % 3 == 0{
            return "FizzBuzz"
        }
        else if questionNum % 3 == 0 {
            return "Fizz"
        }
        else if questionNum % 5 == 0 {
            return "Buzz"
        }
        else {
            return "None"
        }
    }
    // 解答が正しいか確認
    func answerCheck() -> Bool {
        if correctAnswer == userChoiceAnswer {
            return true
        }
        else {
            return false
        }
    }
}

class QuestionDataManager {
    // シングルトンのオブジェクト生成
    static let sharedInstance = QuestionDataManager()
    // 問題を格納するための配列
    var questionDataArray = [QuestionData]()
    // 何問目かをカウントする
    var nowQuestionIndex: Int = 0
    // 初期化処理
    private init(){
    }
    func makeQuestion() {
        // 格納済みのデータを削除
        questionDataArray.removeAll()
        // 現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        // 問題の数字と答えをセット
        for i in 0...9 {
            questionDataArray.append(QuestionData())
            questionDataArray[i].makeQustionNum()
            print("questionNum = \(questionDataArray[i].questionNum),correctAnswer = \(questionDataArray[i].correctAnswer) ")
        }
    }
    // 次の問題を返す
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < 10 {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
}
