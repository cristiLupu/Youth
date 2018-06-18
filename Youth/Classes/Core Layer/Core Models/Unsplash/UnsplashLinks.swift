//
//  UnsplashLinks.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/**
 Struct which contains links
 */
public struct UnsplashLinks {

    public let `self`: URL?
    public let html: URL?
    public let download: URL?
    public let downloadLocation: URL?
    public let photos: URL?
    public let likes: URL?
    public let portfolio: URL?
    public let following: URL?
    public let followers: URL?

}

// MARK: Decodable

extension UnsplashLinks: Decodable {

    private enum CodingKeys: String, CodingKey {
        case `self` = "self"
        case html
        case download
        case downloadLocation = "download_location"
        case photos
        case likes
        case portfolio
        case followers
        case following
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.`self` = try container.decodeIfPresent(URL.self, forKey: .`self`)
        self.html = try container.decodeIfPresent(URL.self, forKey: .html)
        self.download = try container.decodeIfPresent(URL.self, forKey: .download)
        self.downloadLocation = try container.decodeIfPresent(URL.self, forKey: .downloadLocation)
        self.photos = try container.decodeIfPresent(URL.self, forKey: .photos)
        self.likes = try container.decodeIfPresent(URL.self, forKey: .likes)
        self.portfolio = try container.decodeIfPresent(URL.self, forKey: .portfolio)
        self.followers = try container.decodeIfPresent(URL.self, forKey: .followers)
        self.following = try container.decodeIfPresent(URL.self, forKey: .following)
    }

}
