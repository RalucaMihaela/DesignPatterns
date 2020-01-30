//
//  QuestionGroupCell.swift
//  RabbleWabble
//
//  Created by Raluca Ionescu on 11/12/2019.
//  Copyright © 2019 Raluca Ionescu. All rights reserved.
//

import Foundation
import UIKit
import Combine

class QuestionGroupCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var percentageLabel: UILabel!
    
    public var percentageSubscriber: AnyCancellable?
}
