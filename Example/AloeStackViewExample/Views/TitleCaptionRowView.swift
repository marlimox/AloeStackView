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

public class TitleCaptionRowView: UIStackView {

  // MARK: Lifecycle

  public init(titleText: String, captionText: String? = nil) {
    super.init(frame: .zero)
    titleLabel.text = titleText
    captionLabel.text = captionText
    setUpViews()
  }

  public required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private let titleLabel = UILabel()
  private let captionLabel = UILabel()

  private func setUpSelf() {
    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    spacing = 4
  }

  private func setUpViews() {
    setUpSelf()
    setUpTitleLabel()
    setUpCaptionLabel()
  }

  private func setUpTitleLabel() {
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    addArrangedSubview(titleLabel)
  }

  private func setUpCaptionLabel() {
    guard captionLabel.text != nil else { return }
    captionLabel.numberOfLines = 0
    captionLabel.translatesAutoresizingMaskIntoConstraints = false
    captionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
    captionLabel.textColor = .blue
    addArrangedSubview(captionLabel)
  }

}
