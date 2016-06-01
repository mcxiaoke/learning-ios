//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let url = NSURL(string:"file://Users/mcxiaoke/Downloads/IOS.2016003043.jpg")!

url.URLByDeletingPathExtension

url.URLByDeletingLastPathComponent

url.URLByDeletingPathExtension?.lastPathComponent

url.lastPathComponent

url.path

url.pathExtension

url.pathComponents

