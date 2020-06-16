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
 * An object that animates when the Row is inserted and removed from the AloeStackView.
 */
internal class AnimationCoordinator {

  // MARK: Internal

  internal init(target: StackViewCell, state: State, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
    self.target = target
    self.state = state
    self.animations = animations
    self.completion = completion
  }

  internal func startAnimation() {
    willBeginAnimation?()
    UIView.animate(withDuration: AnimationCoordinator.defaultAnimationDuration,
                   delay: 0,
                   usingSpringWithDamping: animatable?.springDamping ?? 1,
                   initialSpringVelocity: 0,
                   options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
                   animations: {
      self.animate?()
      self.animations()
    }) { finished in
      self.animationDidEnd?(finished)
      self.completion?(finished)
    }
  }

  // MARK: Private

  private let target: StackViewCell
  private let state: State
  private let animations: () -> Void
  private let completion: ((Bool) -> Void)?

  private var animatable: CustomAnimating? {
    return target.contentView as? CustomAnimating
  }

  private lazy var willBeginAnimation: (() -> Void)? = {
    switch state {
    case .insert: return animatable?.insertAnimationWillBegin
    case .remove: return animatable?.removeAnimationWillBegin
    }
  }()
    
  private lazy var animate: (() -> Void)? = {
    switch state {
    case .insert: return animatable?.animateInsert
    case .remove: return animatable?.animateRemove
    }
  }()
    
  private lazy var animationDidEnd: ((Bool) -> Void)? = {
    switch state {
    case .insert: return animatable?.insertAnimationDidEnd
    case .remove: return animatable?.removeAnimationDidEnd
    }
  }()

  private static let defaultAnimationDuration: TimeInterval = 0.3

}
