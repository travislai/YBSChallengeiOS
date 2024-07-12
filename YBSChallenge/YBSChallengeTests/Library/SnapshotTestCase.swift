//
//  SnapshotTestCase.swift
//  YBSChallengeTests
//
//  Created by Travis Lai on 12/7/2024.
//

import XCTest
import SnapshotTesting
import SwiftUI

@testable import YBSChallenge

/// Main `Snapshot` testing class. Please use `iPhone 15` simulator to test and generate snapshots

open class SnapshotTestCase: XCTestCase {

    open override func setUp() {
        super.setUp()
        if UIDevice.current.name != "iPhone 15" {
            fatalError("Switch to using iPhone 15 for these tests.")
        }
        UIApplication.shared.keyWindow?.layer.speed = 100
        UIView.setAnimationsEnabled(false)
        isRecording = false
    }

    /// Creates a snapshot using predefined devices. We are only handling for the `dark` ColorScheme at the moment

    func assert<V: View>(_ view: V,
                         devices: SnapshotDevices = .devices,
                         delay: TimeInterval = .zero,
                         testName: String = #function,
                         file: StaticString = #file,
                         line: UInt = #line) {
        devices.forEach { (key: String, value: Snapshotting<UIViewController, UIImage>) in
            assertSnapshot(matching: view.asViewController,
                           as: .wait(for: delay, on: value),
                           named: "\(key)-\(ColorScheme.dark.description)",
                           file: file,
                           testName: testName,
                           line: line)
        }
    }

}

// MARK: - SnapshotDevices

typealias SnapshotDevices = [String: Snapshotting<UIViewController, UIImage>]

extension SnapshotDevices {

    static let devices: Self = [
        "iPhoneSE": .image(on: .iPhoneSe, precision: precision, perceptualPrecision: perceptualPrecision),
        "iPhone13": .image(on: .iPhone13Pro, precision: precision, perceptualPrecision: perceptualPrecision),
        "iPad": .image(on: .iPadMini(.portrait), precision: precision, perceptualPrecision: perceptualPrecision)
    ]
    
    static let devicesWithLongContent: Self = [
        "iPhoneSE": .image(on: .init(safeArea: .zero, size: .init(width: 320, height: 2200), traits: .init()),
                           precision: precision, perceptualPrecision: perceptualPrecision),
        "iPhone13": .image(on: .init(safeArea: .zero, size: .init(width: 390, height: 2200), traits: .init()),
                           precision: precision, perceptualPrecision: perceptualPrecision),
        "iPad": .image(on: .init(safeArea: .zero, size: .init(width: 640, height: 2200),
                                 traits: .init()), precision: precision, perceptualPrecision: perceptualPrecision)
    ]

    static let landscapeDevices: Self = [
        "iPhoneSE": .image(on: .iPhoneSe(.landscape), precision: precision, perceptualPrecision: perceptualPrecision),
        "iPhone13": .image(on: .iPhone13Pro(.landscape), precision: precision, perceptualPrecision: perceptualPrecision),
        "iPad": .image(on: .iPadMini(.landscape), precision: precision, perceptualPrecision: perceptualPrecision)
    ]

    static var perceptualPrecision: Float {
        #if arch(x86_64)
           // When executing on Intel (CI machines) lower the `defaultPerceptualPrecision` to 98% which avoids failing tests
           // due to imperceivable differences in anti-aliasing, shadows, and blurs between Intel and Apple Silicon Macs.
           return 0.98
        #else
           // The snapshots were generated on Apple Silicon Macs, so they match 100%.
           return 1.0
        #endif
    }

    static var precision: Float {
#if arch(x86_64)
        // When executing on Intel (CI machines) lower the `precision` to 98% which avoids failing tests
        // due to imperceivable differences in anti-aliasing, shadows, and blurs between Intel and Apple Silicon Macs.
        return 0.98
#else
        // The snapshots were generated on Apple Silicon Macs, so they match 100%.
        return 1.0
#endif
    }

}

// MARK: - ColorScheme

private extension ColorScheme {

    var description: String {
        switch self {
        case .light:
            return "light"
        case .dark:
            return "dark"
        @unknown default:
            fatalError()
        }
    }
}

// MARK: - View

private extension View {
    
    var asViewController: UIViewController { UIHostingController(rootView: self) }
}

extension UIApplication {

    var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }

}

