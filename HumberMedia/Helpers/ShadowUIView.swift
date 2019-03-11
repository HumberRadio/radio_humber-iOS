//
//  ShadowUIView.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 1/28/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents


class ShadowUIView: UIView {
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }
    
    var shadowLayer: MDCShadowLayer {
        return self.layer as! MDCShadowLayer
    }
    
    func setDefaultElevation() {
        self.shadowLayer.elevation = .cardResting
    }
    
}
