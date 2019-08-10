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

  open override var isHidden: Bool {
    didSet {
      guard isHidden != oldValue else { return }
      separatorView.alpha = isHidden ? 0 : 1
    }
  }

  open var rowHighlightColor = UIColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 1)

  open var rowBackgroundColor = UIColor.clear {
    didSet { backgroundColor = rowBackgroundColor }
  }

  open var rowInset: UIEdgeInsets {
    get { return layoutMargins }
    set { layoutMargins = newValue }
  }

  open var separatorAxis: NSLayoutConstraint.Axis = .horizontal {
    didSet {
      updateSeparatorAxisConstraints()
      updateSeparatorInset()
    }
  }

  open var separatorColor: UIColor {
    get { return separatorView.color }
    set { separatorView.color = newValue }
  }

  open var separatorWidth: CGFloat {
    get { return separatorView.width }
    set { separatorView.width = newValue }
  }

  /// Alias for `separatorWidth`. Maintained for backwards compatibility.
  open var separatorHeight: CGFloat {
    get { return separatorWidth }
    set { separatorWidth = newValue }
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
      contentView.setIsHighlighted(true)
    }
  }

  open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard contentView.isUserInteractionEnabled, let touch = touches.first else { return }

    let locationInSelf = touch.location(in: self)

    if let contentView = contentView as? Highlightable, contentView.isHighlightable {
      let isPointInsideCell = point(inside: locationInSelf, with: event)
      contentView.setIsHighlighted(isPointInsideCell)
    }
  }

  open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    guard contentView.isUserInteractionEnabled else { return }

    if let contentView = contentView as? Highlightable, contentView.isHighlightable {
      contentView.setIsHighlighted(false)
    }
  }

  open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard contentView.isUserInteractionEnabled else { return }

    if let contentView = contentView as? Highlightable, contentView.isHighlightable {
      contentView.setIsHighlighted(false)
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

  private var separatorTopConstraint: NSLayoutConstraint?
  private var separatorBottomConstraint: NSLayoutConstraint?
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
    updateSeparatorAxisConstraints()
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
    separatorTopConstraint = separatorView.topAnchor.constraint(equalTo: topAnchor)
    separatorBottomConstraint = separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
    separatorLeadingConstraint = separatorView.leadingAnchor.constraint(equalTo: leadingAnchor)
    separatorTrailingConstraint = separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
  }

  private func setUpTapGestureRecognizer() {
    tapGestureRecognizer.addTarget(self, action: #selector(handleTap(_:)))
    tapGestureRecognizer.delegate = self
    addGestureRecognizer(tapGestureRecognizer)
    updateTapGestureRecognizerEnabled()
  }

  @objc private func handleTap(_ tapGestureRecognizer: UITapGestureRecognizer) {
    guard contentView.isUserInteractionEnabled else { return }
    (contentView as? Tappable)?.didTapView()
    tapHandler?(contentView)
  }

  private func updateSeparatorAxisConstraints() {
    separatorTopConstraint?.isActive = separatorAxis == .vertical
    separatorBottomConstraint?.isActive = true
    separatorLeadingConstraint?.isActive = separatorAxis == .horizontal
    separatorTrailingConstraint?.isActive = true
  }

  private func updateSeparatorInset() {
    separatorTopConstraint?.constant = separatorInset.top
    separatorBottomConstraint?.constant = separatorAxis == .horizontal ? 0 : -separatorInset.bottom
    separatorLeadingConstraint?.constant = separatorInset.left
    separatorTrailingConstraint?.constant = separatorAxis == .vertical ? 0 : -separatorInset.right
  }

  private func updateTapGestureRecognizerEnabled() {
    tapGestureRecognizer.isEnabled = contentView is Tappable || tapHandler != nil
  }

}

extension StackViewCell: UIGestureRecognizerDelegate {

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    guard let view = gestureRecognizer.view else { return false }

    let location = touch.location(in: view)
    var hitView = view.hitTest(location, with: nil)

    // Traverse the chain of superviews looking for any UIControls.
    while hitView != view && hitView != nil {
      if hitView is UIControl {
        // Ensure UIControls get the touches instead of the tap gesture.
        return false
      }
      hitView = hitView?.superview
    }

    return true
  }

}
