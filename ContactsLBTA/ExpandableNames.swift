//
//  ExpandableNames.swift
//  ContactsLBTA
//
//  Created by De La Cruz, Eduardo on 28/02/2019.
//  Copyright © 2019 De La Cruz, Eduardo. All rights reserved.
//

import Foundation
import Contacts

struct ExpandableNames {
    var isExpanded: Bool
    var contacts: [FavoritableContact]
}

struct FavoritableContact {
//    var name: String
    let contact: CNContact
    var isFavourite: Bool
}
