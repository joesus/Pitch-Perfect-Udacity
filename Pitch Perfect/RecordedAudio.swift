//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by A658308 on 8/12/15.
//  Copyright (c) 2015 Joe Susnick Co. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {

    var title: String!
    var filePathUrl: NSURL!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
