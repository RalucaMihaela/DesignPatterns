//
//  QuestionViewController.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 10/12/2019.
//  Copyright © 2019 Raluca Ionescu. All rights reserved.
//

import UIKit

public class QuestionViewController: UIViewController {
    
    var questionGroup = QuestionGroup.basicPhrases()
    var questionIndex = 0
    var correctCount = 0
    var incorrectCount = 0
     
    var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    private func showQuestion() {
        let question = self.questionGroup.questions[questionIndex]
        self.questionView.answerLabel.text = question.answer
        self.questionView.promptLabel.text = question.prompt
        self.questionView.hintLabel.text = question.hint
        self.questionView.answerLabel.isHidden = true
        self.questionView.hintLabel.isHidden = true
    }
    
    // MARK: - Actions
    
    @IBAction func toggleAnswerLabels(_ sender: Any) {
        self.questionView.answerLabel.isHidden = !self.questionView.answerLabel.isHidden
        self.questionView.hintLabel.isHidden = !self.questionView.hintLabel.isHidden
    }
    
    // 1
    @IBAction func handleCorrect(_ sender: Any) {
        self.correctCount += 1
        self.questionView.correctCountLabel.text = "\(correctCount)"
        self.showNextQuestion()
    }
    // 2
    @IBAction func handleIncorrect(_ sender: Any) {
        self.incorrectCount += 1
        self.questionView.incorrectCountLabel.text = "\(incorrectCount)"
        self.showNextQuestion()
    }
    // 3
    private func showNextQuestion() {
        self.questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            // TODO: - Handle this...!
            return
        }
        self.showQuestion()
    }
}

