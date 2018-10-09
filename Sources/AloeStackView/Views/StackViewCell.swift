// Created by Marli Oshlack on 11/1/16.
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

/**
 * A view that wraps every row in a stack view.
 */
open class StackViewCell: UIView {

  // MARK: Lifecycle

  public init(contentView: UIView) {
    self.contentView = contentView

    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    if #available(iOS 11.0, *) {
      insetsLayoutMarginsFromSafeArea = false
    }

    setUpViews()
    setUpConstraints()
    setUpTapGestureRecognizer()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Open

  open var rowBackgroundColor = UIColor.clear {
    didSet {
      backgroundColor = rowBackgroundColor
    }
  }

  open var rowInset: UIEdgeInsets {
    get { return layoutMargins }
    set { layoutMargins = newValue }
  }

  open var separatorColor: UIColor {
    get { return separatorView.color }
    set { separatorView.color = newValue }
  }

  open var separatorHeight: CGFloat {
    get { return separatorView.height }
    set { separatorView.height = newValue }
  }

  open var separatorInset: UIEdgeInsets = .zero {
    didSet { updateSeparatorInset() }
  }

  open var isSeparatorHidden: Bool {
    get { return separatorView.isHidden }
    set { separatorView.isHidden = newValue }
  }

  // MARK: Public

  public let contentView: UIView

  // MARK: UIResponder

  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard contentView.isUserInteractionEnabled else { return }

    if let contentView = contentView as? Highlightable, contentView.isHighlightable {
      // TODO: make this customizeable.
      backgroundColor = UIColor(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1)
    }
  }

  open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard contentView.isUserInteractionEnabled else { return }

    if let contentView = contentView as? Highlightable, contentView.isHighlightable {
      backgroundColor = rowBackgroundColor
    }
  }

  open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard contentView.isUserInteractionEnabled else { return }

    if let contentView = contentView as? Highlightable, contentView.isHighlightable {
      backgroundColor = rowBackgroundColor
    }
  }

  // MARK: Internal

  internal var tapHandler: ((UIView) -> Void)? {
    didSet { updateTapGestureRecognizerEnabled() }
  }

  // Whether the separator should be hidden or not for this cell. Note that this doesn't always
  // reflect whether the separator is hidden or not, since, for example, the separator could be
  // hidden because it's the last row in the stack view and
  // `automaticallyHidesLastSeparator` is `true`.
  internal var shouldHideSeparator = false

  // MARK: Private

  private let separatorView = SeparatorView()
  private let tapGestureRecognizer = UITapGestureRecognizer()

  private var separatorLeadingConstraint: NSLayoutConstraint?
  private var separatorTrailingConstraint: NSLayoutConstraint?

  private func setUpViews() {
    setUpSelf()
    setUpContentView()
    setUpSeparatorView()
  }

  private func setUpSelf() {
    clipsToBounds = true
  }

  private func setUpContentView() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(contentView)
  }

  private func setUpSeparatorView() {
    addSubview(separatorView)
  }

  private func setUpConstraints() {
    setUpContentViewConstraints()
    setUpSeparatorViewConstraints()
  }

  private func setUpContentViewConstraints() {
    let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
    bottomConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)

    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      bottomConstraint
    ])
  }

  private func setUpSeparatorViewConstraints() {
    let leadingConstraint = separatorView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let trailingConstraint = separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)

    NSLayoutConstraint.activate([
      separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
      leadingConstraint,
      trailingConstraint
    ])

    separatorLeadingConstraint = leadingConstraint
    separatorTrailingConstraint = trailingConstraint
  }

  private func setUpTapGestureRecognizer() {
    tapGestureRecognizer.addTarget(self, action: #selector(handleTap(_:)))
    addGestureRecognizer(tapGestureRecognizer)
    updateTapGestureRecognizerEnabled()
  }

  @objc private func handleTap(_ tapGestureRecognizer: UITapGestureRecognizer) {
    guard contentView.isUserInteractionEnabled else { return }
    (contentView as? Tappable)?.didTapView()
    tapHandler?(contentView)
  }

  private func updateTapGestureRecognizerEnabled() {
    tapGestureRecognizer.isEnabled = contentView is Tappable || tapHandler != nil
  }

  private func updateSeparatorInset() {
    separatorLeadingConstraint?.constant = separatorInset.left
    separatorTrailingConstraint?.constant = -separatorInset.right
  }

}
