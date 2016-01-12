//
//  PeachTabViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachTabViewController: NSTabViewController {

    override func viewWillAppear() {
        super.viewWillAppear()
        tabView.tabViewType = .NoTabsNoBorder
    }
    
    // This is the only safe way to allow callbacks
    // when a tab has changed
    
//    override func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
//        hiddenTabDelegate?.tabView(tabView, didSelectTabViewItem: tabViewItem)
//        super.tabView(tabView, didSelectTabViewItem: tabViewItem)
//    }
    
}
