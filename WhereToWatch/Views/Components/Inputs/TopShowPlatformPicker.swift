//
//  TopShowPlatformPicker.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import SwiftUI

struct TopShowPlatformPicker: View {
    @Binding var selectedPlatform: String
    var body: some View {
        Picker("Platform", selection: $selectedPlatform) {
            Text("Netflix")
                .tag("netflix")
            Text("Prime")
                .tag("prime")
            Text("Apple TV")
                .tag("apple")
            Text("HBO Max")
                .tag("max")
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

#Preview {
    TopShowPlatformPicker(selectedPlatform: Binding.constant("netflix"))
}
