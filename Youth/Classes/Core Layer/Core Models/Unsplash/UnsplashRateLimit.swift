//
//  UnsplashRateLimit.swift
//  Youth
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/**
 Rate Limiting

 For applications in demo mode, the Unsplash API currently places a limit of 50 requests per hour.
 After approval for production, this limit is increased to 5000 requests per hour.

 - Note: Note that only the json requests (i.e., those to api.unsplash.com) are counted.
 Image file requests (images.unsplash.com) do not count against your rate limit.
 */
public struct UnsplashRateLimit {

    /// Total limit count
    public let totalLimit: Int64

    /// Total remaining count
    public let remaining: Int64

    /**
     Create rate limit

     - parameter response: Response from http request

     - returns: `Optional` UnsplashRateLimit
    */
    public static func rateLimit(from response: HTTPURLResponse?) -> UnsplashRateLimit? {
        let headerFields = response?.allHeaderFields

        guard let stringTotalLimit = headerFields?["x-ratelimit-limit"] as? String,
            let stringRemaining = headerFields?["x-ratelimit-remaining"] as? String,
            let integerTotalLimit = Int64(stringTotalLimit),
            let integerRemaining = Int64(stringRemaining) else {
                return nil
        }

        return UnsplashRateLimit(totalLimit: integerTotalLimit,
                                 remaining: integerRemaining)
    }

}
