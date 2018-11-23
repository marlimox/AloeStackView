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

  internal init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
  }

  internal required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal
    
  internal var axis: NSLayoutConstraint.Axis = .vertical {
    didSet { invalidateIntrinsicContentSize() }
  }

  internal override var intrinsicContentSize: CGSize {
    switch axis {
    case .horizontal:
      #if swift(>=4.2)
      return CGSize(width: thickness, height: UIView.noIntrinsicMetric)
      #else
      return CGSize(width: thickness, height: UIViewNoIntrinsicMetric)
      #endif
    case .vertical:
      #if swift(>=4.2)
      return CGSize(width: UIView.noIntrinsicMetric, height: thickness)
      #else
      return CGSize(width: UIViewNoIntrinsicMetric, height: thickness)
      #endif
    }
  }

  internal var color: UIColor {
    get { return backgroundColor ?? .clear }
    set { backgroundColor = newValue }
  }

  internal var thickness: CGFloat = 1 {
    didSet { invalidateIntrinsicContentSize() }
  }

}
