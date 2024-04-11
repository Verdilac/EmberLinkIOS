//
//  EventWidgetBundle.swift
//  EventWidget
//
//  Created by Ram Kumar on 2024-04-10.
//

import WidgetKit
import SwiftUI

@main
struct EventWidgetBundle: WidgetBundle {
    var body: some Widget {
        EventWidget()
        EventWidgetLiveActivity()
    }
}
