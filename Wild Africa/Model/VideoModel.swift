//
//  VideoModel.swift
//  Wild Africa
//
//  Created by Sourabh Gapate on 16/05/21.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    // Computed Property
    var thumbnail: String {
        "video-\(id)"
    }
}
