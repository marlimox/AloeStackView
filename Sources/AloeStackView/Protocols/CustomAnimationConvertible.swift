// Created by gwangbeom on 10/29/18.
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
 * The rows in `AloeStackView` help Custom Animation to work.
 *
 * Rows that are added to an `AloeStackView` can conform to this protocol to have their
 * You can freely change the state animation of each contentView when a row is inserted or deleted.
 */
public protocol CustomAnimationConvertible {

  /// Invoked when animated is true when inserting or deleting.
  func willAnimation(with coordinator: AnimationCoordinator)

}
