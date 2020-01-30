//
//  QuestionStrategy.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 10/01/2020.
//  Copyright © 2020 Raluca Ionescu. All rights reserved.
//

import Foundation

public protocol QuestionStrategy: class {
    var groupTitle: String { get }
    var correctCount: Int { get }
    var incorrectCount: Int { get }
    
    func advanceToNextQuestion() -> Bool
    func currentQuestion() -> Question
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)
    
    func getQuestionIndexTitle() -> String
}
