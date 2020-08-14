//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 10/01/2020.
//  Copyright © 2020 Raluca Ionescu. All rights reserved.
//

import Foundation

public class SequentialQuestionStrategy: QuestionStrategy {
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    
    public init(questionGroup: QuestionGroup){
        self.questionGroup = questionGroup
    }
    
    public var groupTitle: String {
        return self.questionGroup.title
    }
    
    public func currentQuestion() -> Question {
        return self.questionGroup.questions[questionIndex]
    }
    
    public func advanceToNextQuestion() -> Bool {
        guard self.questionIndex + 1 < self.questionGroup.questions.count else {
            return false
        }
        self.questionIndex += 1
        return true
    }
    
    public func markQuestionCorrect(_ question: Question) {
        self.correctCount += 1
    }
    
    public func markQuestionIncorrect(_ question: Question) {
        self.incorrectCount += 1
    }
    
    public func getQuestionIndexTitle() -> String {
        return "\(self.questionIndex + 1)" + "\(self.questionGroup.questions.count)"
    }
}
