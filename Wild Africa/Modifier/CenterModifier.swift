//
//  CenterModifier.swift
//  Wild Africa
//
//  Created by Sourabh Gapate on 16/05/21.
//

import SwiftUI

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
