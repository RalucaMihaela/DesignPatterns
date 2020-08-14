//
//  QuestionViewController.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 10/12/2019.
//  Copyright © 2019 Raluca Ionescu. All rights reserved.
//

import UIKit

protocol QuestionViewControllerDelegate: class {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionStrategy: QuestionStrategy)
    func questionViewController(_ viewController: QuestionViewController, didComplete questionStrategy: QuestionStrategy)
}

public class QuestionViewController: UIViewController {
    var questionIndex = 0
    var correctCount = 0
    var incorrectCount = 0
     
    var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    var questionStrategy: QuestionStrategy! {
        didSet {
            self.navigationItem.title = self.questionStrategy.groupTitle
        }
    }
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "",
                        style: .plain,
                        target: nil,
                        action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    weak var delegate: QuestionViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                landscapeImagePhone: nil,
                                                style: .plain,
                                                target: self,
                                                action: action)
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem){
        self.delegate?.questionViewController(self, didCancel: self.questionStrategy)
    }
    
    private func showQuestion() {
        let question = self.questionStrategy.currentQuestion()
        
        self.questionView.answerLabel.text = question.answer
        self.questionView.promptLabel.text = question.prompt
        self.questionView.hintLabel.text = question.hint
        
        self.questionView.answerLabel.isHidden = true
        self.questionView.hintLabel.isHidden = true
        
        self.questionIndexItem.title = self.questionStrategy.getQuestionIndexTitle()
    }
    
    // MARK: - Actions
    
    @IBAction func toggleAnswerLabels(_ sender: Any) {
        self.questionView.answerLabel.isHidden = !self.questionView.answerLabel.isHidden
        self.questionView.hintLabel.isHidden = !self.questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        let question = self.questionStrategy.currentQuestion()
        self.questionStrategy.markQuestionCorrect(question)
        self.questionView.correctCountLabel.text = String(self.questionStrategy.correctCount)
        self.showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) {
        let question = self.questionStrategy.currentQuestion()
        self.questionStrategy.markQuestionIncorrect(question)
        self.questionView.incorrectCountLabel.text = String(self.questionStrategy.incorrectCount)
        self.showNextQuestion()
    }
    
    private func showNextQuestion() {
        guard self.questionStrategy.advanceToNextQuestion() else {
            self.delegate?.questionViewController(self, didComplete: self.questionStrategy)
            return
        }
        self.showQuestion()
    }
}

