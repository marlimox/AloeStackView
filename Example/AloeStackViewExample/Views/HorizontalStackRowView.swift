// Created by ApptekStudios on 11/24/18.

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

public class HorizontalStackRowView: AloeStackView {

  // MARK: Lifecycle

  public init() {
    super.init(withAxis: .horizontal)
    setUpViews()
  }

  public required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private let labels: [UILabel] = (1...9).map { i in
    let label = UILabel()
    label.text = "Label #\(i)"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    return label
  }

  private func setUpViews() {
    labels.forEach { addRow($0) }
  }
  
}
