//
//  CanvasView.swift
//  Drawings
//
//  Created by mcxiaoke on 16/5/6.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa

class CanvasView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}

/**
 
 Challenge: A Drawing App
 
 Create a new document-based application that allows the user to draw ovals in arbitrary locations and sizes. NSBezierPath has the following initializer:
 init(ovalInRect: NSRect) -> NSBezierPath
 If you are feeling ambitious, add the ability to save and read files.
 If you are feeling extra ambitious, add undo capabilities.
 
 **/
