// Created by Arthur Pang on 9/22/16.
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

internal final class SeparatorView: UIView {

  // MARK: Lifecycle

  internal init(axis: NSLayoutConstraint.Axis) {
    self.stackViewAxes = axis
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
  }

  internal required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal
    
  private let stackViewAxes: NSLayoutConstraint.Axis

  internal override var intrinsicContentSize: CGSize {
    return stackViewAxes.isVertical ? verticalIntrinsicContentSize : horizontalIntrinsicContentSize
  }
    
  private var verticalIntrinsicContentSize: CGSize {
    #if swift(>=4.2)
    return CGSize(width: UIView.noIntrinsicMetric, height: height)
    #else
    return CGSize(width: UIViewNoIntrinsicMetric, height: height)
    #endif
  }
    
  private var horizontalIntrinsicContentSize: CGSize {
    #if swift(>=4.2)
    return CGSize(width: width, height: UIView.noIntrinsicMetric)
    #else
    return CGSize(width: width, height: UIViewNoIntrinsicMetric)
    #endif
  }

  internal var color: UIColor {
    get { return backgroundColor ?? .clear }
    set { backgroundColor = newValue }
  }

  internal var height: CGFloat = 1 {
    didSet { invalidateIntrinsicContentSize() }
  }
    
  internal var width: CGFloat = 1 {
    didSet { invalidateIntrinsicContentSize() }
  }

}
