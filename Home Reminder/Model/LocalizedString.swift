//
//  LocalizedString.swift
//  Home Mention
//
//  Created by Владислав on 02/10/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.main, value: "", comment: "")
    }
}
