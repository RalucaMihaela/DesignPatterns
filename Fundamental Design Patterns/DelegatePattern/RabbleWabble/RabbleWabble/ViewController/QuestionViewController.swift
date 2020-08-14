//
//  QuestionViewController.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 10/12/2019.
//  Copyright © 2019 Raluca Ionescu. All rights reserved.
//

import UIKit

protocol QuestionViewControllerDelegate: class {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int)
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup)
}

public class QuestionViewController: UIViewController {
    var questionIndex = 0
    var correctCount = 0
    var incorrectCount = 0
     
    var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
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
        self.delegate?.questionViewController(self, didCancel: questionGroup, at: questionIndex)
    }
    
    private func showQuestion() {
        let question = self.questionGroup.questions[questionIndex]
        self.questionView.answerLabel.text = question.answer
        self.questionView.promptLabel.text = question.prompt
        self.questionView.hintLabel.text = question.hint
        self.questionView.answerLabel.isHidden = true
        self.questionView.hintLabel.isHidden = true
        self.questionIndexItem.title = "\(self.questionIndex + 1)/" + "\(self.questionGroup.questions.count)"
    }
    
    // MARK: - Actions
    
    @IBAction func toggleAnswerLabels(_ sender: Any) {
        self.questionView.answerLabel.isHidden = !self.questionView.answerLabel.isHidden
        self.questionView.hintLabel.isHidden = !self.questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        self.correctCount += 1
        self.questionView.correctCountLabel.text = "\(correctCount)"
        self.showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) {
        self.incorrectCount += 1
        self.questionView.incorrectCountLabel.text = "\(incorrectCount)"
        self.showNextQuestion()
    }
    
    private func showNextQuestion() {
        self.questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            self.delegate?.questionViewController(self, didComplete: questionGroup)
            return
        }
        self.showQuestion()
    }
}

