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
 * Notifies a row in an `AloeStackView` when it receives a user tap.
 *
 * Rows that are added to an `AloeStackView` can conform to this protocol to be notified when a
 * user taps on the row. This notification happens regardless of whether the row has a tap handler
 * set for it or not.
 *
 * This notification can be used to implement default behavior in a view that should always happen
 * when that view is tapped.
 */
public protocol Tappable {

  /// Called when the row is tapped by the user.
  func didTapView()

}
