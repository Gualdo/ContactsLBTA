//
//  ExpandableNames.swift
//  ContactsLBTA
//
//  Created by De La Cruz, Eduardo on 28/02/2019.
//  Copyright © 2019 De La Cruz, Eduardo. All rights reserved.
//

import Foundation

struct ExpandableNames {
    var isExpanded: Bool
    var contacts: [Contact]
}

struct Contact {
    var name: String
    var isFavourite: Bool
}
