//
//  ModalView.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 02/02/2021.
//

import SwiftUI

struct ModalView<Parent: View, Content: View>: View {

    // MARK: - Private stored properties
    private let content: Content
    private let parent: Parent
    private let canDismiss: Bool
    @Binding private var isPresented: Bool

    // MARK: - Internal methods
    init(isPresented: Binding<Bool>,
                parent: Parent,
                canDismiss: Bool,
                @ViewBuilder content: () -> Content) {
        self.parent = parent
        self.content = content()
        self.canDismiss = canDismiss
        self._isPresented = isPresented
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                parent
                    .animation(nil)
                    .animation(.easeIn)
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(isPresented ? Color.black.opacity(0.65) : Color.clear)
                    .onTapGesture { canDismiss ? isPresented = false : () }
                    .animation(.easeInOut)
                if isPresented {
                    content
                        .frame(maxHeight: proxy.size.height - proxy.safeAreaInsets.bottom)
                        .zIndex(1000)
                        .padding(16)
                        .padding(.top, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .fixedSize(horizontal: false, vertical: true)
                        .shadow(color: Color.black.opacity(0.35), radius: 16, x: 0, y: 6)
                        .transition(AnyTransition.scaleOpacityFromTheBottom.animation(Animation.easeInOut(duration: 0.3)))
                        .transition(AnyTransition.scale)
                }
            }
        }
    }
}

private extension AnyTransition {
    static let scaleOpacityFromTheBottom = AnyTransition.scale(scale: 0.0, anchor: .bottom).combined(with: .opacity)
}

extension View {
    public func modal<ModalContent: View>(isPresented: Binding<Bool>,
                                          canDismiss: Bool = true,
                                          content: () -> ModalContent) -> some View {
        ModalView(isPresented: isPresented,
                    parent: self,
                    canDismiss: canDismiss,
                    content: content)
    }
}
