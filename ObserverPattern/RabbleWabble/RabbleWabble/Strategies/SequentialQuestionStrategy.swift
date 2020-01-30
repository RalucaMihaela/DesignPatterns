//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 10/01/2020.
//  Copyright © 2020 Raluca Ionescu. All rights reserved.
//

import Foundation

public class SequentialQuestionStrategy: BaseQuestionStrategy {
  
    convenience init(questionGroupCaretaker: QuestionGroupCaretaker){
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let questions = questionGroup.questions
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
