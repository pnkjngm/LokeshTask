//
//  DataModel.swift
//  Task
//
//  Created by Vyas, Lokesh Kumar on 03/03/19.
//  Copyright © 2019 Vyas, Lokesh Kumar. All rights reserved.
//

import Foundation

struct SectionData {
    let title: String
    let data : [String]
    
    var numberOfItems: Int {
        return data.count
    }
    
    subscript(index: Int) -> String {
        return data[index]
    }
}

extension SectionData {
    init(title: String, data: String...) {
        self.title = title
        self.data  = data
    }
}
