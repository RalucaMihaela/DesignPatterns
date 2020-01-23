//
//  QuestionGroup.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 10/12/2019.
//  Copyright © 2019 Raluca Ionescu. All rights reserved.
//

import Foundation

public class QuestionGroup: Codable {
    public let questions: [Question]
    public var score: Score
    public let title: String
    
    public init(questions: [Question],
                score: Score = Score(),
                title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}

public class Score: Codable {
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0
    public init() {}
}
