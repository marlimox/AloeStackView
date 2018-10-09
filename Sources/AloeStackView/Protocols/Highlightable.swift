// Created by Marli Oshlack on 11/14/16.
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

/**
 * Indicates that a row in an `AloeStackView` should change its background color to a
 * highlighted color when a user is touching it.
 *
 * Rows that are added to an `AloeStackView` can conform to this protocol to have their
 * background color automatically change to a highlighted color when the user is pressing down on
 * them.
 */
public protocol Highlightable {

  /// Checked when the user touches down on a row to determine whether the background color of the
  /// row should be changed to a highlighted color.
  ///
  /// The default implementation of this method always returns `true`.
  var isHighlightable: Bool { get }

}

extension Highlightable {

  public var isHighlightable: Bool {
    get { return true }
  }

}
