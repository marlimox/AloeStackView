// Created by Marli Oshlack on 11/14/16.
// Copyright 2018 Airbnb, Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

/**
 * Indicates that a row in an `AloeStackView` should be highlighted when it touches
 *
 * Rows that are added to an `AloeStackView` can conform to this protocol to have their
 * highlightAction(isHighlighting:) will be performed when the user is pressing down on
 * them.
 */
public protocol Highlightable {

  /// If the user touches the row, the row should be highlighted.
  ///
  /// The default implementation of this method always returns `true`.
  var isHighlightable: Bool { get }
  
  /// You can custom highlight the touch action of each row in the AloeStackView
  ///
  /// The default action is to change the background color of each row.
  func highlightAction(isHighlighting: Bool)
}

extension Highlightable where Self: UIView {
    
  public var isHighlightable: Bool {
    return true
  }
    
  public func highlightAction(isHighlighting: Bool) {
    guard let cell = superview as? StackViewCell else { return }
    if isHighlighting {
      cell.backgroundColor = cell.highlightRowBackgroundColor
    } else {
      cell.backgroundColor = cell.rowBackgroundColor
    }
  }
}
