//
//  SegmentedControlView.swift
//  CustomSegmentView
//
//  Created by Arun Rathore on 02/03/24.
//

import SwiftUI

struct SegmentedControlView: View {
    @Binding private var selectedIndex: Int
    
    @State private var frames: Array<CGRect>
    @State private var backgroundFrame = CGRect.zero
    @State private var isScrollable = true
    
    private let titles: [String]
    
    init(selectedIndex: Binding<Int>, titles: [String]) {
        self._selectedIndex = selectedIndex
        self.titles = titles
        frames = Array<CGRect>(repeating: .zero, count: titles.count)
    }
    
    var body: some View {
        VStack {
            if isScrollable {
                ScrollView(.horizontal, showsIndicators: false) {
                    SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable, titles: titles)
                }
            } else {
                SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable, titles: titles)
            }
        }
        .background(
            GeometryReader { geoReader in
                Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                    .onPreferenceChange(RectPreferenceKey.self) {
                        self.setBackgroundFrame(frame: $0)
                    }
            }
        )
    }
    
    private func setBackgroundFrame(frame: CGRect) {
        backgroundFrame = frame
        checkIsScrollable()
    }
    
    private func checkIsScrollable() {
        if frames[frames.count - 1].width > .zero {
            var width = CGFloat.zero
            
            for frame in frames {
                width += frame.width
            }
            
            if isScrollable && width <= backgroundFrame.width {
                isScrollable = false
            } else if !isScrollable && width > backgroundFrame.width {
                isScrollable = true
            }
        }
    }
}

