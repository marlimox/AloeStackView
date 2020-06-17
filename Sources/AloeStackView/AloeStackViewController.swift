// Created by Fan Cox on 11/30/16.
// Copyright Marli Oshlack 2018.

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
 * A view controller that specializes in managing an AloeStackView.
 */
open class AloeStackViewController: UIViewController {

  // MARK: Lifecycle

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func loadView() {
    view = stackView
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if automaticallyFlashScrollIndicators {
        stackView.flashScrollIndicators()
    }
  }
    
  open override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if stackViewCanAlwaysScroll {
      if stackView.contentSize.height < view.frame.size.height {
      var bottomPadding: CGFloat = 0
      if #available(iOS 11.0, *) {
        bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
      }
      // contentSize height need to bigger than view height
      stackView.contentSize = CGSize(width: 0, height: view.frame.size.height - bottomPadding + 0.5)
      }
    }
  }

  // MARK: Public

  /// The stack view this controller manages.
  public let stackView = AloeStackView()

  /// When true, automatically displays the scroll indicators in the stack view momentarily whenever the view appears.
  ///
  /// Default is `false`.
  open var automaticallyFlashScrollIndicators = false
    
  /// When true, stackView can always scroll
  ///
  /// Default is `true`.
  open var stackViewCanAlwaysScroll = true

}
