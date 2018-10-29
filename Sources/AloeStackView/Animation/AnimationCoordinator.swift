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

import UIKit

/**
 * An object that animates when the Row is inserted and deleted from the AloeStackView.
 */
public class AnimationCoordinator {

  // MARK: Internal

  internal init(target: StackViewCell, state: State, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
    self.target = target
    self.state = state
    self.animations = animations
    self.completion = completion
  }

  internal func startAnimation() {
    (target.contentView as? CustomAnimationConvertible)?.willAnimation(with: self)
    UIView.animate(withDuration: AnimationCoordinator.defaultAnimationDuration, animations: {
      self.animations()
      self.alongsideAnimation?()
    }) { success in
      self.completion?(success)
      self.alongsideCompletion?(success)
    }
  }

  // MARK: Public

  public let state: State

  /// AloeStackView gives you the opportunity to change state values ​​by taking over the animation behavior when Row is added and removed.
  public func animate(alongsideAnimation animation: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
    alongsideAnimation = animation
    alongsideCompletion = completion
  }

  // MARK: Private

  private let target: StackViewCell
  private let animations: () -> Void
  private let completion: ((Bool) -> Void)?

  private var alongsideAnimation: (() -> Void)?
  private var alongsideCompletion: ((Bool) -> Void)?

  private static let defaultAnimationDuration: TimeInterval = 0.3

}
