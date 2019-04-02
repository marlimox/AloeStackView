// Created by Marli Oshlack on 10/12/18.
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

public class MainViewController: AloeStackViewController {

  // MARK: Public

  public override func viewDidLoad() {
    super.viewDidLoad()
    setUpSelf()
    setUpStackView()
    setUpRows()
  }

  // MARK: Private

  private func setUpSelf() {
    title = "AloeStackView Example"
  }

  private func setUpStackView() {
    stackView.automaticallyHidesLastSeparator = true
  }

  private func setUpRows() {
    setUpDescriptionRow()
    setUpSwitchRow()
    setUpHiddenRows()
    setUpExpandingRowView()
    setUpPhotoRow()
    setUpHorizontalStackRowView()
  }

  private func setUpDescriptionRow() {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    label.text = "This simple app shows some ways you can use AloeStackView to lay out a screen in your app."
    stackView.addRow(label)
  }

  private func setUpSwitchRow() {
    let switchRow = SwitchRowView()
    switchRow.text = "Show and hide rows with animation"
    switchRow.switchDidChange = { [weak self] isOn in
      guard let self = self else { return }
      self.stackView.setRowsHidden(self.hiddenRows, isHidden: !isOn, animated: true)
    }
    stackView.addRow(switchRow)
  }

  private let hiddenRows = [UILabel(), UILabel(), UILabel(), UILabel(), UILabel()]

  private func setUpHiddenRows() {
    for (index, row) in hiddenRows.enumerated() {
      row.font = UIFont.preferredFont(forTextStyle: .caption2)
      row.text = "Hidden row " + String(index + 1)
    }

    stackView.addRows(hiddenRows)
    stackView.hideRows(hiddenRows)

    let rowInset = StackViewCell.Inset(leading: stackView.rowInset.leading * 2, trailing: stackView.rowInset.trailing)

    let separatorInset = StackViewCell.Inset(leading: stackView.separatorInset.leading * 2, trailing: stackView.separatorInset.trailing)

    stackView.setInset(forRows: hiddenRows, inset: rowInset)
    stackView.setSeparatorInset(forRows: Array(hiddenRows.dropLast()), inset: separatorInset)
  }

  private func setUpExpandingRowView() {
    let expandingRow = ExpandingRowView()
    stackView.addRow(expandingRow)
  }

  private func setUpPhotoRow() {
    let titleLabel = UILabel()
    titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    titleLabel.numberOfLines = 0
    titleLabel.text = "Handle user interaction"
    stackView.addRow(titleLabel)
    stackView.hideSeparator(forRow: titleLabel)
    stackView.setPadding(forRow: titleLabel, padding: .init(before: stackView.rowPadding.before, after: 4))

    let captionLabel = UILabel()
    captionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
    captionLabel.textColor = .blue
    captionLabel.numberOfLines = 0
    captionLabel.text = "(Try tapping on the photo!)"
    stackView.addRow(captionLabel)
    stackView.hideSeparator(forRow: captionLabel)
    stackView.setPadding(forRow: captionLabel, padding: .init(before: 0, after: stackView.rowPadding.after))

    guard let image = UIImage(named: "lobster-dog") else { return }
    let aspectRatio = image.size.height / image.size.width

    let imageView = UIImageView(image: image)
    imageView.isUserInteractionEnabled = true
    imageView.contentMode = .scaleAspectFit
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio).isActive = true

    stackView.addRow(imageView)
    stackView.setTapHandler(forRow: imageView) { [weak self] _ in
      guard let self = self else { return }
      let vc = PhotoViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }

  private func setUpHorizontalStackRowView() {
    let view = HorizontalStackRowView()
    stackView.addRow(view)
  }
  
}
