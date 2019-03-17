// Created by gwangbeom on 10/29/18.
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

/**
 * The rows in `AloeStackView` help Custom Animation to work.
 *
 * Rows that are added to an `AloeStackView` can conform to this protocol to have their
 * You can freely change the state animation of each contentView when a row is inserted or removed.
 */

import UIKit

public protocol CustomAnimating {

  /// The springDamping value used to determine the amount of 'bounce'
  /// seen when animationing to insert or remove state
  ///
  /// Default Value is 0.8.
  var springDamping: CGFloat { get }

  /// Called before insert animation is activated.
  func insertAnimationWillBegin()

  /// Called when insert animation is working.
  func animateInsert()

  /// Called after insert animation.
  func insertAnimationDidEnd(_ finished: Bool)
    
  /// Called before remove animation is activated.
  func removeAnimationWillBegin()
    
  /// Called when remove animation is working.
  func animateRemove()
    
  /// Called after remove animation.
  func removeAnimationDidEnd(_ finished: Bool)

}

public extension CustomAnimating where Self: UIView {

  var springDamping: CGFloat {
    return 0.8
  }

  func animateInsert() { }

  func insertAnimationWillBegin() { }

  func insertAnimationDidEnd(_ finished: Bool) { }

  func animateRemove() { }

  func removeAnimationWillBegin() { }

  func removeAnimationDidEnd(_ finished: Bool) { }

}
