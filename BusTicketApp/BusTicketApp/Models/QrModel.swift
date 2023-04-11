//
//  QrModel.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 10.04.2023.
//

import Foundation
import UIKit

struct QrModel {
    
    var qrImage: UIImage
    
    init(qrImage: UIImage = UIImage()) {
        self.qrImage = qrImage
    }
}
