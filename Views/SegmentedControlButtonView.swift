//
//  SegmentedControlButtonView.swift
//  CustomSegmentView
//
//  Created by Arun Rathore on 02/03/24.
//

import SwiftUI

 struct SegmentedControlButtonView: View {
    @Binding private var selectedIndex: Int
    @Binding private var frames: [CGRect]
    @Binding private var backgroundFrame: CGRect
    @Binding private var isScrollable: Bool

    private let titles: [String]
    let checkIsScrollable: (() -> Void)

    init(selectedIndex: Binding<Int>, frames: Binding<[CGRect]>, backgroundFrame: Binding<CGRect>, isScrollable: Binding<Bool>, checkIsScrollable: (@escaping () -> Void), titles: [String]) {
        _selectedIndex = selectedIndex
        _frames = frames
        _backgroundFrame = backgroundFrame
        _isScrollable = isScrollable

        self.checkIsScrollable = checkIsScrollable
        self.titles = titles
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(titles.indices, id: \.self) { index in
                Button(action:{ selectedIndex = index }) {
                    HStack {
                        Text(titles[index])
                            .frame(height: 42)
                    }
                }
                .buttonStyle(CustomSegmentButtonStyle())
                .background(
                    GeometryReader { geoReader in
                        Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                            .onPreferenceChange(RectPreferenceKey.self) {
                                self.setFrame(index: index, frame: $0)
                            }
                    }
                )
            }
        }
        .modifier(UnderlineModifier(selectedIndex: selectedIndex, frames: frames))
    }

    private func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame

        checkIsScrollable()
    }
}

private struct CustomSegmentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
            .background(configuration.isPressed ? Color(red: 0.808, green: 0.831, blue: 0.855, opacity: 0.5): Color.clear)
    }
}
