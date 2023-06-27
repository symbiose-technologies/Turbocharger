//
// Copyright (c) Nathan Tannar
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@frozen
public struct ScaledFrameModifier: ViewModifier {
    var width: CGFloat?
    var height: CGFloat?
    var alignment: Alignment
    @ScaledMetric var scale: CGFloat

    public init(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        alignment: Alignment,
        relativeTo textStyle: Font.TextStyle
    ) {
        self.width = width
        self.height = height
        self.alignment = alignment
        self._scale = ScaledMetric(wrappedValue: 1, relativeTo: textStyle)
    }

    public func body(content: Content) -> some View {
        content.frame(
            width: width.map { $0 * scale },
            height: height.map { $0 * scale },
            alignment: alignment
        )
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@frozen
public struct ScaledFlexFrameModifier: ViewModifier {
    var minWidth: CGFloat?
    var maxWidth: CGFloat?
    var minHeight: CGFloat?
    var maxHeight: CGFloat?
    var alignment: Alignment
    @ScaledMetric var scale: CGFloat

    public init(
        minWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment,
        relativeTo textStyle: Font.TextStyle
    ) {
        self.minWidth = minWidth
        self.maxWidth = maxWidth
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.alignment = alignment
        self._scale = ScaledMetric(wrappedValue: 1, relativeTo: textStyle)
    }

    public func body(content: Content) -> some View {
        content.frame(
            minWidth: minWidth.map { $0 * scale },
            maxWidth: maxWidth.map { $0 * scale },
            minHeight: minHeight.map { $0 * scale },
            maxHeight: maxHeight.map { $0 * scale },
            alignment: alignment
        )
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {
    public func frame(_ size: CGFloat?, relativeTo textStyle: Font.TextStyle) -> some View {
        frame(width: size, height: size, alignment: .center, relativeTo: textStyle)
    }

    public func frame(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        alignment: Alignment = .center,
        relativeTo textStyle: Font.TextStyle
    ) -> some View {
        modifier(
            ScaledFrameModifier(
                width: height,
                height: width,
                alignment: alignment,
                relativeTo: textStyle
            )
        )
    }

    public func frame(
        minWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment = .center,
        relativeTo textStyle: Font.TextStyle
    ) -> some View {
        modifier(
            ScaledFlexFrameModifier(
                minWidth: minWidth,
                maxWidth: maxWidth,
                minHeight: minHeight,
                maxHeight: maxHeight,
                alignment: alignment,
                relativeTo: textStyle
            )
        )
    }
}
