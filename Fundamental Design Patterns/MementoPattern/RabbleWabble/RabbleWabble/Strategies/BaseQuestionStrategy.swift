//
//  BaseQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 22/01/2020.
//  Copyright © 2020 Raluca Ionescu. All rights reserved.
//

import Foundation


public class BaseQuestionStrategy: QuestionStrategy {
    
    public var correctCount: Int {
        get { return questionGroup.score.correctCount }
        set { questionGroup.score.correctCount = newValue }
    }
    
    public var incorrectCount: Int {
        get { return questionGroup.score.incorrectCount }
        set { questionGroup.score.incorrectCount = newValue }
    }
    
    private var questionGroupCaretaker: QuestionGroupCaretaker

    private var questionGroup: QuestionGroup {
        return questionGroupCaretaker.selectedQuestionGroup
    }
    private var questionIndex = 0
    private let questions: [Question]
    
    // MARK: - Object Lifecycle

    public init(questionGroupCaretaker: QuestionGroupCaretaker, questions: [Question]) {
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions
        self.questionGroupCaretaker.selectedQuestionGroup.score = QuestionGroup.Score()
    }
    
    // MARK: - QuestionStrategy
    
    public var groupTitle: String {
        return questionGroup.title
    }
    public func currentQuestion() -> Question {
        return questions[questionIndex]
    }
    public func advanceToNextQuestion() -> Bool {
        try? self.questionGroupCaretaker.save()
        guard questionIndex + 1 < questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }

    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }
    public func getQuestionIndexTitle() -> String {
        return "\(questionIndex + 1)/\(questions.count)"
    }
}
