//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 11/12/2019.
//  Copyright © 2019 Raluca Ionescu. All rights reserved.
//

import Foundation
import UIKit

class SelectQuestionGroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, QuestionViewControllerDelegate {
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    public let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
    private let appSettings = AppSettings.shared
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.questionGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? QuestionViewController else { return }
        viewController.questionStrategy = appSettings.questionStrategy(for: selectedQuestionGroup)
        viewController.delegate = self
    }
    
    // MARK: - QuestionViewControllerDelegate
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionStrategy: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func questionViewController(_ viewController: QuestionViewController, didCancel questionStrategy: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
}

