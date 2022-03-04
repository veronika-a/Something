//
//  SelfConfiguringCell.swift
//  Something
//
//  Created by Veronika Andrianova on 25.01.2022.
//

import Foundation
import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with intValue: Int)
}
