//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 14/01/2020.
//  Copyright © 2020 Raluca Ionescu. All rights reserved.
//

import Foundation
import GameplayKit

public class RandomQuestionStrategy: QuestionStrategy {
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    private let questions: [Question]
    
    init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
        
        let randomSource = GKRandomSource.sharedRandom()
        self.questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
    }
    
    public var groupTitle: String {
        return self.questionGroup.title
    }
    
    public func currentQuestion() -> Question {
        return self.questions[self.questionIndex]
    }
    
    public func advanceToNextQuestion() -> Bool {
        guard self.questionIndex + 1 < self.questions.count else {
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
        return "\(self.questionIndex + 1)/\(self.questions.count)"
    }
    
}
