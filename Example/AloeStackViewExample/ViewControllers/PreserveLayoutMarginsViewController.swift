//  Created by Alexander Bredy on 01/02/2019.
//  Copyright © 2019 Airbnb, Inc. All rights reserved.

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

public class PreserveLayoutMarginsViewController: AloeStackViewController {

  // MARK: Public

  public override func viewDidLoad() {
    super.viewDidLoad()
    setUpSelf()
    setUpStackView()
    setUpRows()
  }

  // MARK: Private

  private func setUpSelf() {
    title = "Preserve superview layout margins"
  }

  private func setUpStackView() {
    // Setting this property to true will constrain the stack view content within the layout margins of the superview
    stackView.preservesSuperviewLayoutMargins = true

    // Setting separator and row insets on this screen will add additional margins to the ones set by the
    // superview.
    stackView.separatorInset = .zero
    stackView.rowInset = .zero
  }

  private func setUpRows() {
    setUpDescriptionRow()
    setUpAnotherRow()
  }

  private func setUpDescriptionRow() {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    label.text = "The margins of the AloeStackView in this screen include the ones from the superview layout margins."
    stackView.addRow(label)
  }

  private func setUpAnotherRow() {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    label.text = "Check out this ViewController on both iPhone and iPad to see the margins difference!"
    stackView.addRow(label)
  }
}
