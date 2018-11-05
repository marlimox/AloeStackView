// Created by Giuseppe Travasoni on 05/11/2018.
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

public class HorizontalViewController: UIViewController {
    
    // MARK: Public
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        setUpSelf()
        setUpHorizontalStack()
        setUpSwitchRow()
        setUpHiddenRows()
        setUpTenExampleRows()
    }
    
    // MARK: Private
    
    private weak var stackView: AloeStackView?
    
    private func setUpSelf() {
        title = "Horizontal Aloe Stack View"
    }
    
    private func setUpHorizontalStack() {
        let stack = AloeStackView(withAxis: .horizontal)
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        stackView = stack
    }
    
    private func setUpSwitchRow() {
        
        guard let stackView = stackView else { return }
        
        let switchRow = SwitchRowView()
        switchRow.text = "Show and hide rows with animation"
        switchRow.switchDidChange = { [weak self] isOn in
            guard let self = self else { return }
            self.stackView?.setRowsHidden(self.hiddenRows, isHidden: !isOn, animated: true)
        }
        stackView.addRow(switchRow)
    }
    
    private let hiddenRows = [UILabel(), UILabel(), UILabel(), UILabel(), UILabel()]
    
    private func setUpHiddenRows() {
        
        guard let stackView = stackView else { return }
        
        for (index, row) in hiddenRows.enumerated() {
            row.font = UIFont.preferredFont(forTextStyle: .caption2)
            row.text = "Hidden row " + String(index + 1)
        }
        
        stackView.addRows(hiddenRows)
        stackView.hideRows(hiddenRows)
        
        let rowInset = UIEdgeInsets(
            top: stackView.rowInset.top,
            left: stackView.rowInset.left * 2,
            bottom: stackView.rowInset.bottom,
            right: stackView.rowInset.right)
        
        let separatorInset = UIEdgeInsets(
            top: 0,
            left: stackView.separatorInset.left * 2,
            bottom: 0,
            right: 0)
        
        stackView.setInset(forRows: hiddenRows, inset: rowInset)
        stackView.setSeperatorInset(forRows: Array(hiddenRows.dropLast()), inset: separatorInset)
    }
    
    private func setUpTenExampleRows() {
        
        for item in 0..<10 {
            
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.numberOfLines = 0
            label.text = "Example " + "\(item)"
            stackView?.addRow(label)
        }
    }
}
