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

public class TitleCaptionRow: UIStackView {

  // MARK: Lifecycle

  public init(title: String, captionText: String? = nil) {
    self.title = title
    self.captionText = captionText
    super.init(frame: .zero)
    setUpSelf()
    setUpViews()
  }

  public required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private let title: String
  private let captionText: String?

  private let titleLabel = UILabel()
  private let captionLabel = UILabel()

  private func setUpSelf() {
    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    spacing = 4
  }

  private func setUpViews() {
    setUpTitleLabel()
    setUpCaptionLabel()
  }

  private func setUpTitleLabel() {
    titleLabel.text = title
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    addArrangedSubview(titleLabel)
  }

  private func setUpCaptionLabel() {
    guard let captionText = captionText else { return }
    captionLabel.text = captionText
    captionLabel.numberOfLines = 0
    captionLabel.translatesAutoresizingMaskIntoConstraints = false
    captionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
    captionLabel.textColor = .blue
    addArrangedSubview(captionLabel)
  }

}
