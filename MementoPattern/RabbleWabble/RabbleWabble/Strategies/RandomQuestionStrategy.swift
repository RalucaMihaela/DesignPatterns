//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 14/01/2020.
//  Copyright © 2020 Raluca Ionescu. All rights reserved.
//

import Foundation
import GameplayKit

public class RandomQuestionStrategy: BaseQuestionStrategy {

    convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
