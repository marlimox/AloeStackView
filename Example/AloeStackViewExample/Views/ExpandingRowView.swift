// Created by Marli Oshlack on 10/14/18.
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

import AloeStackView
import UIKit

public class ExpandingRowView: UIStackView, Tappable, Highlightable {

  // MARK: Lifecycle

  public init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    setUpViews()
  }

  public required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Public

  public func didTapView() {
    textLabel.text = (textLabel.text ?? "") + "\n" + lines[nextLine]
    nextLine += 1
    if nextLine == lines.count {
      nextLine = 0
    }
  }

  // MARK: Private

  private let titleLabel = UILabel()
  private let showMoreLabel = UILabel()
  private let textLabel = UILabel()

  private var nextLine = 1

  private func setUpViews() {
    setUpSelf()
    setUpTitleLabel()
    setUpShowMoreLabel()
    setUpTextLabel()
  }

  private func setUpSelf() {
    axis = .vertical
    spacing = 4
  }

  private func setUpTitleLabel() {
    titleLabel.text = "Dynamically change row content"
    titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    addArrangedSubview(titleLabel)
  }

  private func setUpShowMoreLabel() {
    showMoreLabel.numberOfLines = 0
    showMoreLabel.text = "(Tap on this row to add more content!)\n"
    showMoreLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
    showMoreLabel.textColor = .blue
    addArrangedSubview(showMoreLabel)
  }

  private func setUpTextLabel() {
    textLabel.numberOfLines = 0
    textLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
    textLabel.text = lines[0]
    addArrangedSubview(textLabel)
  }

  private let lines = [
    "Two households, both alike in dignity,",
    "In fair Verona, where we lay our scene,",
    "From ancient grudge break to new mutiny,",
    "Where civil blood makes civil hands unclean.",
    "From forth the fatal loins of these two foes",
    "A pair of star-cross'd lovers take their life;",
    "Whose misadventured piteous overthrows",
    "Do with their death bury their parents' strife.",
    "The fearful passage of their death-mark'd love,",
    "And the continuance of their parents' rage,",
    "Which, but their children's end, nought could remove,",
    "Is now the two hours' traffic of our stage;",
    "The which if you with patient ears attend,",
    "What here shall miss, our toil shall strive to mend."
  ]

}
