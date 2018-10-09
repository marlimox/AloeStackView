// Created by Marli Oshlack on 2/7/17.
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
 * Indicates that a row in an `AloeStackView` should hide its separator.
 *
 * Rows that are added to an `AloeStackView` can conform to this protocol to automatically their
 * separators.
 *
 * This behavior can be useful when implementing shared, reusable rows that should always have this
 * behavior when they are used in an `AloeStackView`.
 */
public protocol SeparatorHiding {
}
