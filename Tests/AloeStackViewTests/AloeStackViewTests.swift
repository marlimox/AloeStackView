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

import XCTest

@testable import AloeStackView

final class AloeStackViewTests: XCTestCase {

  func test() {
  }

  func testSetRowHiddenDuplicateCalls() {
    let stackView = AloeStackView()
    let row = UIView()
    stackView.addRow(row)

    stackView.setRowHidden(row, isHidden: true, animated: true)
    stackView.setRowHidden(row, isHidden: true, animated: true)
    stackView.setRowHidden(row, isHidden: false, animated: true)

    XCTAssertFalse(stackView.isRowHidden(row))
  }

  func testInsertedRowIsFirstAndLastRow() {
    let stackView = AloeStackView()
    let row = UIView()
    stackView.addRow(row)
    XCTAssertTrue(stackView.firstRow === row)
    XCTAssertTrue(stackView.lastRow === row)
  }
  
  func testStackViewHasFirstAndLastRow() {
    let stackView = AloeStackView()
    let firstRow = UIView()
    let middleRow = UILabel()
    let lastRow = UIButton()
    stackView.addRows([firstRow, middleRow, lastRow])
    XCTAssertTrue(stackView.firstRow === firstRow)
    XCTAssertTrue(stackView.lastRow === lastRow)
  }
  
}
