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

private let FontCellIdentifier = "FontCellIdentifier"

class FontsTableViewController: UITableViewController {
    private let styles = [
        UIFontTextStyleTitle1: "iOS9",
        UIFontTextStyleTitle2: "iOS9",
        UIFontTextStyleTitle3: "iOS9",
        UIFontTextStyleHeadline: "iOS7",
        UIFontTextStyleSubheadline: "iOS7",
        UIFontTextStyleBody: "iOS7",
        UIFontTextStyleFootnote: "iOS7",
        UIFontTextStyleCaption1: "iOS7",
        UIFontTextStyleCaption2: "iOS7",
        UIFontTextStyleCallout: "iOS9"
    ]
    private var keys: [String]!
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        keys = Array(styles.keys)
        keys.sortInPlace()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        tableView.estimatedRowHeight = 44
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FontCellIdentifier, forIndexPath: indexPath) as! FontDemoCell
        
        let key = keys[indexPath.row]
        let availableOn = styles[key]!
        
        cell.setShowFont(key, availableOn: availableOn)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @objc private func contentSizeChanged() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
    }
}
