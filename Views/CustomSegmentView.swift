//
//  CustomSegmentView.swift
//  CustomSegmentView
//
//  Created by Arun Rathore on 02/03/24.
//

import SwiftUI

struct CustomSegmentView: View {
    @State var selectedIndex: Int = 0

    let titles: [String] =
        ["First",
         "Second",
         "Third",
         "Fourth",
         "Fifth",
         "Sixth",
         "Seventh",
         "Eighth",
         "Ninth",
         "Tenth",
         "Eleventh",
         "Twelfth",
         "Thirteenth",
         "Fourteenth",
         "Fifteenth",
         "Sixteenth",
         "Seventeenth",
         "Eighteenth",
         "Nineteenth",
         "Tweentieth"
        ]

    var body: some View {
        VStack {
            SegmentedControlView(selectedIndex: $selectedIndex, titles: titles)
            Spacer(minLength: 0)
        }
    }
}
