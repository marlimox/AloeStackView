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

import UIKit

public class SwitchRowView: UIView {

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

  public var text: String? {
    get { return label.text }
    set { label.text = newValue}
  }

  public var switchDidChange: ((_ isOn: Bool) -> Void)?

  // MARK: Private

  private let label = UILabel()
  private let switchView = UISwitch(frame: .zero)

  private func setUpViews() {
    setUpLabel()
    setUpSwitchView()
  }

  private func setUpLabel() {
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    addSubview(label)
  }

  private func setUpSwitchView() {
    switchView.translatesAutoresizingMaskIntoConstraints = false
    switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    addSubview(switchView)
  }

  @objc private func switchChanged() {
    switchDidChange?(switchView.isOn)
  }

  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      switchView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
      switchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
      switchView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -1)
    ])
  }

}
