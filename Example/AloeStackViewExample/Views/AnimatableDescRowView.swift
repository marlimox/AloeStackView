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

public class AnimatableDescRowView: UIView {

  // MARK: Lifecycle

  public init() {
    super.init(frame: .zero)
    setUpViews()
    setUpConstraints()
  }

  public required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Public

  public var isSelected: Bool = false

  // MARK: Private
    
  private let titleLabel = UILabel()
  private let captionLabel = UILabel()
    
  private func setUpViews() {
    setUpTitleLabel()
    setUpCaptionLabel()
  }
    
  private func setUpTitleLabel() {
    titleLabel.text = "Customizing Row Animation"
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    addSubview(titleLabel)
  }
    
  private func setUpCaptionLabel() {
    captionLabel.translatesAutoresizingMaskIntoConstraints = false
    captionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
    captionLabel.textColor = .blue
    captionLabel.text = "(Try tapping on the Row!)"
    addSubview(captionLabel)
  }
    
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      captionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      captionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

}
