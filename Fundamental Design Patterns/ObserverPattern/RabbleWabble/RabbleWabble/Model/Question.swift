//
//  QuestionModel.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 10/12/2019.
//  Copyright © 2019 Raluca Ionescu. All rights reserved.
//

import Foundation

public class Question: Codable {
    public let answer: String
    public let hint: String?
    public let prompt: String
    
    init(answer: String, hint: String?, prompt: String) {
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
    }
}
