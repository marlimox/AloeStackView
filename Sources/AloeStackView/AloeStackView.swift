// Created by Marli Oshlack on 11/10/16.
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
 * A simple class for laying out a collection of views with a convenient API, while leveraging the
 * power of Auto Layout.
 */
open class AloeStackView: UIScrollView {

  // MARK: Lifecycle

  public init() {
    super.init(frame: .zero)
    setUpViews()
    setUpConstraints()
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  // MARK: Adding and Removing Rows

  /// Adds a row to the end of the stack view.
  ///
  /// If `animated` is `true`, the insertion is animated.
  open func addRow(_ row: UIView, animated: Bool = false) {
    insertCell(withContentView: row, atIndex: stackView.arrangedSubviews.count, animated: animated)
  }

  /// Adds multiple rows to the end of the stack view.
  ///
  /// If `animated` is `true`, the insertions are animated.
  open func addRows(_ rows: [UIView], animated: Bool = false) {
    rows.forEach { addRow($0, animated: animated) }
  }

  /// Adds a row to the beginning of the stack view.
  ///
  /// If `animated` is `true`, the insertion is animated.
  open func prependRow(_ row: UIView, animated: Bool = false) {
    insertCell(withContentView: row, atIndex: 0, animated: animated)
  }

  /// Adds multiple rows to the beginning of the stack view.
  ///
  /// If `animated` is `true`, the insertions are animated.
  open func prependRows(_ rows: [UIView], animated: Bool = false) {
    rows.reversed().forEach { prependRow($0, animated: animated) }
  }

  /// Inserts a row above the specified row in the stack view.
  ///
  /// If `animated` is `true`, the insertion is animated.
  open func insertRow(_ row: UIView, before beforeRow: UIView, animated: Bool = false) {
    guard
      let cell = beforeRow.superview as? StackViewCell,
      let index = stackView.arrangedSubviews.index(of: cell) else { return }

    insertCell(withContentView: row, atIndex: index, animated: animated)
  }

  /// Inserts multiple rows above the specified row in the stack view.
  ///
  /// If `animated` is `true`, the insertions are animated.
  open func insertRows(_ rows: [UIView], before beforeRow: UIView, animated: Bool = false) {
    rows.forEach { insertRow($0, before: beforeRow, animated: animated) }
  }

  /// Inserts a row below the specified row in the stack view.
  ///
  /// If `animated` is `true`, the insertion is animated.
  open func insertRow(_ row: UIView, after afterRow: UIView, animated: Bool = false) {
    guard
      let cell = afterRow.superview as? StackViewCell,
      let index = stackView.arrangedSubviews.index(of: cell) else { return }

    insertCell(withContentView: row, atIndex: index + 1, animated: animated)
  }

  /// Inserts multiple rows below the specified row in the stack view.
  ///
  /// If `animated` is `true`, the insertions are animated.
  open func insertRows(_ rows: [UIView], after afterRow: UIView, animated: Bool = false) {
    _ = rows.reduce(afterRow) { currentAfterRow, row in
      insertRow(row, after: currentAfterRow, animated: animated)
      return row
    }
  }

  /// Removes the given row from the stack view.
  ///
  /// If `animated` is `true`, the removal is animated.
  open func removeRow(_ row: UIView, animated: Bool = false) {
    if let cell = row.superview as? StackViewCell {
      removeCell(cell, animated: animated)
    }
  }

  /// Removes the given rows from the stack view.
  ///
  /// If `animated` is `true`, the removals are animated.
  open func removeRows(_ rows: [UIView], animated: Bool = false) {
    rows.forEach { removeRow($0, animated: animated) }
  }

  /// Removes all the rows in the stack view.
  ///
  /// If `animated` is `true`, the removals are animated.
  open func removeAllRows(animated: Bool = false) {
    stackView.arrangedSubviews.forEach { view in
      if let cell = view as? StackViewCell {
        removeRow(cell.contentView, animated: animated)
      }
    }
  }

  // MARK: Accessing Rows

  /// Returns an array containing of all the rows in the stack view.
  ///
  /// The rows in the returned array are in the order they appear visually in the stack view.
  open func getAllRows() -> [UIView] {
    var rows: [UIView] = []
    stackView.arrangedSubviews.forEach { cell in
      if let cell = cell as? StackViewCell {
        rows.append(cell.contentView)
      }
    }
    return rows
  }

  /// Returns `true` if the given row is present in the stack view, `false` otherwise.
  open func containsRow(_ row: UIView) -> Bool {
    guard let cell = row.superview as? StackViewCell else { return false }
    return stackView.arrangedSubviews.contains(cell)
  }

  // MARK: Hiding and Showing Rows

  /// Hides the given row, making it invisible.
  ///
  /// If `animated` is `true`, the change is animated.
  open func hideRow(_ row: UIView, animated: Bool = false) {
    setRowHidden(row, isHidden: true, animated: animated)
  }

  /// Hides the given rows, making them invisible.
  ///
  /// If `animated` is `true`, the changes are animated.
  open func hideRows(_ rows: [UIView], animated: Bool = false) {
    rows.forEach { hideRow($0, animated: animated) }
  }

  /// Shows the given row, making it visible.
  ///
  /// If `animated` is `true`, the change is animated.
  open func showRow(_ row: UIView, animated: Bool = false) {
    setRowHidden(row, isHidden: false, animated: animated)
  }

  /// Shows the given rows, making them visible.
  ///
  /// If `animated` is `true`, the changes are animated.
  open func showRows(_ rows: [UIView], animated: Bool = false) {
    rows.forEach { showRow($0, animated: animated) }
  }

  /// Hides the given row if `isHidden` is `true`, or shows the given row if `isHidden` is `false`.
  ///
  /// If `animated` is `true`, the change is animated.
  open func setRowHidden(_ row: UIView, isHidden: Bool, animated: Bool = false) {
    guard let cell = row.superview as? StackViewCell else { return }

    if animated {
      UIView.animate(withDuration: 0.3) {
        cell.isHidden = isHidden
        cell.layoutIfNeeded()
      }
    } else {
      cell.isHidden = isHidden
    }
  }

  /// Hides the given rows if `isHidden` is `true`, or shows the given rows if `isHidden` is
  /// `false`.
  ///
  /// If `animated` is `true`, the change are animated.
  open func setRowsHidden(_ rows: [UIView], isHidden: Bool, animated: Bool = false) {
    rows.forEach { setRowHidden($0, isHidden: isHidden, animated: animated) }
  }

  /// Returns `true` if the given row is hidden, `false` otherwise.
  open func isRowHidden(_ row: UIView) -> Bool {
    return (row.superview as? StackViewCell)?.isHidden ?? false
  }

  // MARK: Handling User Interaction

  /// Sets a closure that will be called when the given row in the stack view is tapped by the user.
  ///
  /// The handler will be passed the row.
  open func setTapHandler<RowView: UIView>(forRow row: RowView, handler: ((RowView) -> Void)?) {
    guard let cell = row.superview as? StackViewCell else { return }

    if let handler = handler {
      cell.tapHandler = { contentView in
        guard let contentView = contentView as? RowView else { return }
        handler(contentView)
      }
    } else {
      cell.tapHandler = nil
    }
  }

  // MARK: Styling Rows

  /// The background color of rows in the stack view.
  ///
  /// This background color will be used for any new row that is added to the stack view.
  /// The default color is clear.
  open var rowBackgroundColor = UIColor.clear

  /// Sets the background color for the given row to the `UIColor` provided.
  open func setBackgroundColor(forRow row: UIView, color: UIColor) {
    (row.superview as? StackViewCell)?.rowBackgroundColor = color
  }

  /// Sets the background color for the given rows to the `UIColor` provided.
  open func setBackgroundColor(forRows rows: [UIView], color: UIColor) {
    rows.forEach { setBackgroundColor(forRow: $0, color: color) }
  }

  /// Specifies the default inset of rows.
  ///
  /// This inset will be used for any new row that is added to the stack view.
  ///
  /// You can use this property to add space between a row and the left and right edges of the stack
  /// view and the rows above and below it. Positive inset values move the row inward and away
  /// from the stack view edges and away from rows above and below.
  ///
  /// The default inset is 15pt on each side and 12pt on the top and bottom.
  open var rowInset = UIEdgeInsets(
    top: 12,
    left: AloeStackView.defaultSeparatorInset.left,
    bottom: 12,
    // Intentional, to match the default spacing of UITableView's cell separators but balanced on
    // each side.
    right: AloeStackView.defaultSeparatorInset.left)

  /// Sets the inset for the given row to the `UIEdgeInsets` provided.
  open func setInset(forRow row: UIView, inset: UIEdgeInsets) {
    (row.superview as? StackViewCell)?.rowInset = inset
  }

  /// Sets the inset for the given rows to the `UIEdgeInsets` provided.
  open func setInset(forRows rows: [UIView], inset: UIEdgeInsets) {
    rows.forEach { setInset(forRow: $0, inset: inset) }
  }

  // MARK: Styling Separators

  /// The color of separators in the stack view.
  ///
  /// The default color matches the default color of separators in `UITableView`.
  open var separatorColor = AloeStackView.defaultSeparatorColor {
    didSet {
      for cell in stackView.arrangedSubviews {
        (cell as? StackViewCell)?.separatorColor = separatorColor
      }
    }
  }

  /// The height of separators in the stack view.
  ///
  /// The default height is 1px.
  open var separatorHeight: CGFloat = 1 / UIScreen.main.scale {
    didSet {
      for cell in stackView.arrangedSubviews {
        (cell as? StackViewCell)?.separatorHeight = separatorHeight
      }
    }
  }

  /// Specifies the default inset of row separators.
  ///
  /// Only left and right insets are honored. This inset will be used for any new row that is added
  /// to the stack view. The default inset matches the default inset of cell separators in
  /// `UITableView`, which are 15pt on the left and 0pt on the right.
  open var separatorInset: UIEdgeInsets = AloeStackView.defaultSeparatorInset

  /// Sets the separator inset for the given row to the `UIEdgeInsets` provided.
  ///
  /// Only left and right insets are honored.
  open func setSeperatorInset(forRow row: UIView, inset: UIEdgeInsets) {
    (row.superview as? StackViewCell)?.separatorInset = inset
  }

  /// Sets the separator inset for the given rows to the `UIEdgeInsets` provided.
  ///
  /// Only left and right insets are honored.
  open func setSeperatorInset(forRows rows: [UIView], inset: UIEdgeInsets) {
    rows.forEach { setSeperatorInset(forRow: $0, inset: inset) }
  }

  // MARK: Hiding and Showing Separators

  /// Specifies the default visibility of row separators.
  ///
  /// When `true`, separators will be hidden for any new rows added to the stack view.
  /// When `false, separators will be visible for any new rows added. Default is `false`, meaning
  /// separators are visible for any new rows that are added.
  open var hidesSeparatorsByDefault = false

  /// Hides the separator for the given row.
  open func hideSeparator(forRow row: UIView) {
    if let cell = row.superview as? StackViewCell {
      cell.shouldHideSeparator = true
      updateSeparatorVisibility(forCell: cell)
    }
  }

  /// Hides separators for the given rows.
  open func hideSeparators(forRows rows: [UIView]) {
    rows.forEach { hideSeparator(forRow: $0) }
  }

  /// Shows the separator for the given row.
  open func showSeparator(forRow row: UIView) {
    if let cell = row.superview as? StackViewCell {
      cell.shouldHideSeparator = false
      updateSeparatorVisibility(forCell: cell)
    }
  }

  /// Shows separators for the given rows.
  open func showSeparators(forRows rows: [UIView]) {
    rows.forEach { showSeparator(forRow: $0) }
  }

  /// Automatically hides the separator of the last cell in the stack view.
  ///
  /// Default is `false`.
  open var automaticallyHidesLastSeparator = false {
    didSet {
      if let cell = stackView.arrangedSubviews.last as? StackViewCell {
        updateSeparatorVisibility(forCell: cell)
      }
    }
  }

  // MARK: Modifying the Scroll Position

  /// Scrolls the given row onto screen so that it is fully visible.
  ///
  /// If `animated` is `true`, the scroll is animated. If the row is already fully visible, this
  /// method does nothing.
  open func scrollRowToVisible(_ row: UIView, animated: Bool = true) {
    guard let superview = row.superview else { return }
    scrollRectToVisible(convert(row.frame, from: superview), animated: animated)
  }

  // MARK: Extending AloeStackView

  /// Returns the `StackViewCell` to be used for the given row.
  ///
  /// An instance of `StackViewCell` wraps every row in the stack view.
  ///
  /// Subclasses can override this method to return a custom `StackViewCell` subclass, for example
  /// to add custom behavior or functionality that is not provided by default.
  ///
  /// If you customize the values of some properties of `StackViewCell` in this method, these values
  /// may be overwritten by default values after the cell is returned. To customize the values of
  /// properties of the cell, override `configureCell(_:)` and perform the customization there,
  /// rather than on the cell returned from this method.
  open func cellForRow(_ row: UIView) -> StackViewCell {
    return StackViewCell(contentView: row)
  }

  /// Allows subclasses to configure the properties of the given `StackViewCell`.
  ///
  /// This method is called for newly created cells after the default values of any properties of
  /// the cell have been set by the superclass.
  ///
  /// The default implementation of this method does nothing.
  open func configureCell(_ cell: StackViewCell) { }

  // MARK: - Private

  private let stackView = UIStackView()

  private func setUpViews() {
    setUpSelf()
    setUpStackView()
  }

  private func setUpSelf() {
    backgroundColor = UIColor.white
  }

  private func setUpStackView() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    addSubview(stackView)
  }

  private func setUpConstraints() {
    setUpStackViewConstraints()
  }

  private func setUpStackViewConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.widthAnchor.constraint(equalTo: widthAnchor)
    ])
  }

  private func createCell(withContentView contentView: UIView) -> StackViewCell {
    let cell = cellForRow(contentView)

    cell.rowBackgroundColor = rowBackgroundColor
    cell.rowInset = rowInset
    cell.separatorColor = separatorColor
    cell.separatorHeight = separatorHeight
    cell.separatorInset = separatorInset
    cell.shouldHideSeparator = hidesSeparatorsByDefault

    configureCell(cell)

    return cell
  }

  private func insertCell(withContentView contentView: UIView, atIndex index: Int, animated: Bool) {
    let cellToRemove = containsRow(contentView) ? contentView.superview : nil

    let cell = createCell(withContentView: contentView)
    stackView.insertArrangedSubview(cell, at: index)

    if let cellToRemove = cellToRemove as? StackViewCell {
      removeCell(cellToRemove, animated: false)
    }

    updateSeparatorVisibility(forCell: cell)

    // A cell can affect the visibility of the cell before it, e.g. if
    // `automaticallyHidesLastSeparator` is true and a new cell is added as the last cell, so update
    // the previous cell's separator visibility as well.
    if let cellAbove = cellAbove(cell: cell) {
      updateSeparatorVisibility(forCell: cellAbove)
    }

    if animated {
      cell.alpha = 0
      layoutIfNeeded()
      UIView.animate(withDuration: 0.3) {
        cell.alpha = 1
      }
    }
  }

  private func removeCell(_ cell: StackViewCell, animated: Bool) {
    let aboveCell = cellAbove(cell: cell)

    let completion: (Bool) -> Void = { [weak self] _ in
      guard let `self` = self else { return }
      cell.removeFromSuperview()

      // When removing a cell, the cell before the removed cell is the only cell whose separator
      // visibility could be affected, so we need to update its visibility.
      if let aboveCell = aboveCell {
        self.updateSeparatorVisibility(forCell: aboveCell)
      }
    }

    if animated {
      UIView.animate(
        withDuration: 0.3,
        animations: {
          cell.isHidden = true
        },
        completion: completion)
    } else {
      completion(true)
    }
  }

  private func updateSeparatorVisibility(forCell cell: StackViewCell) {
    let isLastCellAndHidingIsEnabled = automaticallyHidesLastSeparator &&
      cell === stackView.arrangedSubviews.last
    let cellConformsToSeparatorHiding = cell.contentView is SeparatorHiding

    cell.isSeparatorHidden =
      isLastCellAndHidingIsEnabled ||
      cellConformsToSeparatorHiding ||
      cell.shouldHideSeparator
  }

  private func cellAbove(cell: StackViewCell) -> StackViewCell? {
    guard let index = stackView.arrangedSubviews.index(of: cell), index > 0 else { return nil }
    return stackView.arrangedSubviews[index - 1] as? StackViewCell
  }

  private static let defaultSeparatorColor: UIColor = UITableView().separatorColor ?? .clear
  private static let defaultSeparatorInset: UIEdgeInsets = UITableView().separatorInset

}
