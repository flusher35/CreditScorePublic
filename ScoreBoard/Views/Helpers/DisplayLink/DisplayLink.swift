//
//  DisplayLink.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 30/01/2021.
//

import Combine
import QuartzCore

// A publisher that emits new values when the system is about to update the display.
public final class DisplayLink: Publisher {
    public typealias Output = Frame
    public typealias Failure = Never

    public static let shared = DisplayLink(platformDisplayLink: PlatformDisplayLink())

    private let platformDisplayLink: PlatformDisplayLink

    private var subscribers = [CombineIdentifier : AnySubscriber<Frame, Never>]() {
        didSet {
            dispatchPrecondition(condition: .onQueue(.main))
            platformDisplayLink.isPaused = subscribers.isEmpty
        }
    }

    fileprivate init(platformDisplayLink: PlatformDisplayLink) {
        dispatchPrecondition(condition: .onQueue(.main))
        self.platformDisplayLink = platformDisplayLink
        self.platformDisplayLink.onFrame = { [weak self] frame in
            self?.send(frame: frame)
        }
    }

    public func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Never, S.Input == Frame {
        dispatchPrecondition(condition: .onQueue(.main))

        let typeErased = AnySubscriber(subscriber)
        let identifier = typeErased.combineIdentifier
        let subscription = Subscription(onCancel: { [weak self] in
            self?.cancelSubscription(for: identifier)
        })
        subscribers[identifier] = typeErased
        subscriber.receive(subscription: subscription)
    }

    private func cancelSubscription(for identifier: CombineIdentifier) {
        dispatchPrecondition(condition: .onQueue(.main))
        subscribers.removeValue(forKey: identifier)
    }

    private func send(frame: Frame) {
        dispatchPrecondition(condition: .onQueue(.main))
        let subscribers = self.subscribers.values
        subscribers.forEach {
            _ = $0.receive(frame) // Ignore demand
        }
    }
}

extension DisplayLink {

    // Represents a frame that is about to be drawn
    public struct Frame {

        // The system timestamp for the frame to be drawn
        public var timestamp: TimeInterval

        // The duration between each display update
        public var duration: TimeInterval
    }

}

extension DisplayLink {

    fileprivate final class Subscription: Combine.Subscription {

        var onCancel: () -> Void

        init(onCancel: @escaping () -> Void) {
            self.onCancel = onCancel
        }

        func request(_ demand: Subscribers.Demand) {
            // Do nothing – subscribers can't impact how often the system draws frames.
        }

        func cancel() {
            onCancel()
        }
    }
}

/// DisplayLink is used to hook into screen refreshes.
extension DisplayLink {

    fileprivate final class PlatformDisplayLink {

        /// The callback to call for each frame.
        var onFrame: ((Frame) -> Void)? = nil

        /// If the display link is paused or not.
        var isPaused: Bool {
            get { displayLink.isPaused }
            set { displayLink.isPaused = newValue }
        }

        /// The CADisplayLink that powers this DisplayLink instance.
        let displayLink: CADisplayLink

        /// The target for the CADisplayLink (because CADisplayLink retains its target).
        let target = DisplayLinkTarget()

        /// Creates a new paused DisplayLink instance.
        init() {
            displayLink = CADisplayLink(target: target, selector: #selector(DisplayLinkTarget.frame(_:)))
            displayLink.isPaused = true
            displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.common)

            target.callback = { [unowned self] (frame) in
                self.onFrame?(frame)
            }
        }

        deinit {
            displayLink.invalidate()
        }

        /// The target for the CADisplayLink (because CADisplayLink retains its target).
        final class DisplayLinkTarget {

            /// The callback to call for each frame.
            var callback: ((DisplayLink.Frame) -> Void)? = nil

            /// Called for each frame from the CADisplayLink.
            @objc dynamic func frame(_ displayLink: CADisplayLink) {

                let frame = Frame(
                    timestamp: displayLink.timestamp,
                    duration: displayLink.duration)

                callback?(frame)
            }
        }
    }
}
