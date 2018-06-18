//
//  YouthCollectionLayout.swift
//  Youth
//
//  Created by Lupu Cristian on 5/10/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public enum YouthCollectionLayout: Int {
    case grid = 0
    case list = 1

    public var inversed: YouthCollectionLayout {
        switch self {
        case .grid:
            return .list
        case .list:
            return .grid
        }
    }
}
