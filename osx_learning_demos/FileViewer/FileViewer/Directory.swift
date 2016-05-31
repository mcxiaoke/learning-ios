/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import AppKit

let requiredAttributes = [NSURLLocalizedNameKey, NSURLEffectiveIconKey,NSURLTypeIdentifierKey,NSURLCreationDateKey,NSURLFileSizeKey, NSURLIsDirectoryKey,NSURLIsPackageKey]

public struct Metadata : CustomDebugStringConvertible , Equatable {
  
  let name:String
  let date:NSDate
  let size:Int64
  let icon:NSImage
  let color:NSColor
  let isFolder:Bool
  let url:NSURL
  
  init(fileURL:NSURL, name:String, date:NSDate, size:Int64, icon:NSImage, isFolder:Bool, color:NSColor ) {
    self.name  = name
    self.date = date
    self.size = size
    self.icon = icon
    self.color = color
    self.isFolder = isFolder
    url = fileURL
  }
  
  public var debugDescription: String {
    return name + " " + "Folder: \(isFolder)" + " Size: \(size)"
  }
  
  public static func create(fileURL url:NSURL, withName name:String? = nil) -> Metadata? {
    do{
      let properties = try  url.resourceValuesForKeys(requiredAttributes)
      return Metadata(fileURL: url,
                name: name ?? (properties[NSURLLocalizedNameKey] as? String ?? ""),
                date: properties[NSURLCreationDateKey] as? NSDate ?? NSDate.distantPast(),
                size: (properties[NSURLFileSizeKey] as? NSNumber)?.longLongValue ?? 0,
                icon: properties[NSURLEffectiveIconKey] as? NSImage  ?? NSImage(),
                isFolder: (properties[NSURLIsDirectoryKey] as? NSNumber)?.boolValue ?? false,
                color: NSColor())
    }
    catch {
      print("Error reading file attributes")
      return nil
    }
  }
  
}

//MARK:  Metadata  Equatable
public func ==(lhs: Metadata, rhs: Metadata) -> Bool {
  return lhs.url.isEqual(rhs.url)
}


public struct Directory  {
  
  private var files = [Metadata]()
  let url:NSURL
  
  public enum FileOrder : String {
    case Name
    case Date
    case Size
  }
  
  public init( folderURL:NSURL ) {
    url = folderURL
    let requiredAttributes = [NSURLLocalizedNameKey, NSURLEffectiveIconKey,NSURLTypeIdentifierKey,NSURLCreationDateKey,NSURLFileSizeKey, NSURLIsDirectoryKey,NSURLIsPackageKey]
    if let enumerator = NSFileManager.defaultManager().enumeratorAtURL(folderURL, includingPropertiesForKeys: requiredAttributes, options: [.SkipsHiddenFiles, .SkipsPackageDescendants, .SkipsSubdirectoryDescendants], errorHandler: nil) {
      
      while let url  = enumerator.nextObject() as? NSURL {
//        print( "\(url )")
        if let meta = Metadata.create(fileURL: url){
          files.append(meta)
        }
      }
    }
  }
  
  
  func contentsOrderedBy(orderedBy:FileOrder, ascending:Bool) -> [Metadata] {
    let sortedFiles:[Metadata]
    switch orderedBy
    {
    case .Name:
      sortedFiles = files.sort{ return sortMetadata(lhsIsFolder:true, rhsIsFolder: true, ascending: ascending, attributeComparation:itemComparator(lhs:$0.name, rhs: $1.name, ascending:ascending)) }
    case .Size:
      sortedFiles = files.sort{ return sortMetadata(lhsIsFolder:true, rhsIsFolder: true, ascending:ascending, attributeComparation:itemComparator(lhs:$0.size, rhs: $1.size, ascending: ascending)) }
    case .Date:
      sortedFiles = files.sort{ return sortMetadata(lhsIsFolder:true, rhsIsFolder: true, ascending:ascending, attributeComparation:itemComparator(lhs:$0.date, rhs: $1.date, ascending:ascending)) }
    }
    return sortedFiles
  }
 
}

//MARK: - Sorting
func sortMetadata(lhsIsFolder lhsIsFolder:Bool, rhsIsFolder:Bool,  ascending:Bool , attributeComparation:Bool ) -> Bool
{
  if( lhsIsFolder && !rhsIsFolder) {
    return ascending ? true : false
  }
  else if ( !lhsIsFolder && rhsIsFolder ) {
    return ascending ? false : true
  }
  return attributeComparation
}

func itemComparator<T:Comparable>( lhs lhs:T, rhs:T, ascending:Bool ) -> Bool {
  return ascending ? (lhs < rhs) : (lhs > rhs)
}


//MARK: NSDate Comparable Extension
extension NSDate: Comparable {
  
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
  if lhs.compare(rhs) == .OrderedSame {
    return true
  }
  return false
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
  if lhs.compare(rhs) == .OrderedAscending {
    return true
  }
  return false
}
