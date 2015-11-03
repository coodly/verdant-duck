/*
* Copyright 2015 Coodly LLC
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit

class FontDemoCell: UITableViewCell {
    private var style: String!
    private var availableOn: String!
    @IBOutlet private var demoLabel: UILabel!
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }


    override func awakeFromNib() {
        super.awakeFromNib()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    func setShowFont(style: String, availableOn: String) {
        self.style = style
        self.availableOn = availableOn
        updateFont()
        updateText()
    }
    
    private func updateText() {
        demoLabel!.text = "\(availableOn) - \(style) - \(demoLabel.font.pointSize)"
    }
    
    private func updateFont() {
        demoLabel!.font = UIFont.preferredFontForTextStyle(style)
    }

    @objc private func contentSizeChanged() {
        updateFont()
    }
}
