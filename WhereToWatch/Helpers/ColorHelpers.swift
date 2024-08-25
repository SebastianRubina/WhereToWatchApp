//
//  ColorHelpers.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import Foundation
import SwiftUI

struct ColorHelpers {
    static func getScoreColor(score: Double) -> Color {
        switch score {
        case 1...25:
            return .red
        case 26...50:
            return .orange
        case 51...75:
            return .yellow
        case 76...100:
            return .green
        default:
            return .clear
        }
    }
}
