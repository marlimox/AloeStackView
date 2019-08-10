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
    setUpConstraints()
  }

  internal required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  internal override var intrinsicContentSize: CGSize {
    return CGSize(width: width, height: width)
  }

  internal var color: UIColor {
    get { return backgroundColor ?? .clear }
    set { backgroundColor = newValue }
  }

  internal var width: CGFloat = 1 {
    didSet { invalidateIntrinsicContentSize() }
  }

  // MARK: Private

  private func setUpConstraints() {
    setContentHuggingPriority(.defaultLow, for: .horizontal)
    setContentHuggingPriority(.defaultLow, for: .vertical)
    setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    setContentCompressionResistancePriority(.defaultLow, for: .vertical)
  }

}
