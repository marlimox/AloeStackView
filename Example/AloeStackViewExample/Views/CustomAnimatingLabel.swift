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
import AloeStackView

public class CustomAnimatingLabel: UILabel, CustomAnimating {

  public func willAnimate(with coordinator: AnimationCoordinator) {
    let isInsertState = coordinator.state == .insert
    transform = isInsertState ? CGAffineTransform(translationX: -100, y: 0) : .identity
    alpha = isInsertState ? 0 : 1

    coordinator.animate(alongsideAnimation: {
      self.transform = isInsertState ? .identity : CGAffineTransform(translationX: -100, y: 0)
      self.alpha = isInsertState ? 1 : 0
    })
  }

}
