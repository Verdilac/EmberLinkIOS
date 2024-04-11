//
//  EventWidgetView.swift
//  EventWidgetExtension
//
//  Created by Ram Kumar on 2024-04-10.
//

import SwiftUI
import WidgetKit

struct EventWidgetView: View {


    var body: some View {
        VStack(alignment:.leading, spacing:10){

            Text("Upcoming events")
                .font(Font.headline)
                .foregroundColor(Color.primary)


            HStack{
                RoundedRectangle(cornerRadius: 1)
                    .fill(travel.reservation != nil ? Color.green : Color.red)
                    .frame(width: 2, height: 37)
                Text(travel.destination!).font(.title)
            }
        }
    }
}
