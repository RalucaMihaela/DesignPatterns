//
//  AppSettings.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 15/01/2020.
//  Copyright © 2020 Raluca Ionescu. All rights reserved.
//

import Foundation

public class AppSettings {
    
    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }
    
    private let userDefaults = UserDefaults.standard
    
    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        } set {
            userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    
    public static let shared = AppSettings()
    
    private init() {}
    
    // get the QuestionStrategy from the selected  strategyType
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        return self.questionStrategyType.questionStrategy(for: questionGroupCaretaker)
    }
}

public enum QuestionStrategyType: Int, CaseIterable {
    case random
    case sequential
    
    public func title() -> String {
        switch self {
        case .random:
            return "Random"
        case .sequential:
            return "Sequential"
        }
    }
    
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        switch self {
        case .random:
            return RandomQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        case .sequential:
            return SequentialQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        }
    }
}
