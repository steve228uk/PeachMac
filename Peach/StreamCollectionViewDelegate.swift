//
//  StreamCollectionViewDelegate.swift
//  Peach
//
//  Created by Stephen Radford on 21/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

extension StreamViewController: NSCollectionViewDataSource {
    
    // MARK: - NSCollectionViewDatasource & Delegate
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts[section].message.count + 1
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        
        guard indexPath.item != posts[indexPath.section].message.count else {
            return CGSizeMake(collectionView.frame.size.width, 50)
        }
        
        let message = posts[indexPath.section].message[indexPath.item]
        
        switch message.type {
        case .Text:
            if let textMessage = message as? TextMessage {
                if let text = textMessage.text {
                    let calculatedHeight = text.calculatedHeightForFont(NSFont.systemFontOfSize(14), width: collectionView.frame.size.width-40)
                    
                    return CGSizeMake(collectionView.frame.size.width, calculatedHeight)
                }
            }
        case .Image, .GIF:
            
            if let imageMessage = message as? ImageMessage {
                guard imageMessage.width != nil else {
                    return CGSizeMake(collectionView.frame.size.width, 80)
                }
                
                let width = CGFloat(imageMessage.width!)
                let height = CGFloat(imageMessage.height!)
                let calculatedHeight = (collectionView.frame.size.width) * height / width
                
                return CGSizeMake(collectionView.frame.size.width, calculatedHeight)
            }
        case .Video :
            if let videoMessage = message as? VideoMessage {
                guard videoMessage.width != nil else {
                    return CGSizeMake(collectionView.frame.size.width, 80)
                }
                
                let width = CGFloat(videoMessage.width!)
                let height = CGFloat(videoMessage.height!)
                let calculatedHeight = (collectionView.frame.size.width) * height / width
                
                return CGSizeMake(collectionView.frame.size.width, calculatedHeight)
            }
        default:
            return CGSizeMake(collectionView.frame.size.width, 20)
        }
        
        // final catch
        return CGSizeMake(collectionView.frame.size.width, 20)
    }
    
    
    
    // MARK: - Cell Content
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        
        guard indexPath.item != posts[indexPath.section].message.count else {
            let item = collectionView.makeItemWithIdentifier("actionsItem", forIndexPath: indexPath) as! PostActionsItem
            item.post = posts[indexPath.section]
            return item
        }
        
        
        let message = posts[indexPath.section].message[indexPath.item]
        
        switch message.type {
        case .Image, .Shout, .Drawing:
            return imageCellForIndexPath(indexPath)
        case .GIF:
            return gifCellForIndexPath(indexPath)
        case .Video, .LoopingPhoto:
            return videoCellForIndexPath(indexPath)
        case .Music:
            return musicCellForIndexPath(indexPath)
        case .Location:
            return locationCellForIndexPath(indexPath)
        case .Link:
            return linkCellForIndexPath(indexPath)
        case .Text:
            return textCellForIndexPath(indexPath)
        }
        
        
    }
    
    /**
     Make a new PostTextItem for the indexPath
     
     - parameter indexPath: Current indexPath
     
     - returns: The item
     */
    func textCellForIndexPath(indexPath: NSIndexPath) -> PostTextItem {
        let item = collectionView.makeItemWithIdentifier("textItem", forIndexPath: indexPath) as! PostTextItem
        let textMessage = posts[indexPath.section].message[indexPath.item] as! TextMessage
        if let text = textMessage.text {
            item.textLabel.stringValue = text
        }
        return item
    }
    
    /**
     Make a new PostImageItem for the indexPath
     
     - parameter indexPath: Current indexPath
     
     - returns: The item
     */
    func imageCellForIndexPath(indexPath: NSIndexPath) -> PostImageItem {
        let item = collectionView.makeItemWithIdentifier("imageItem", forIndexPath: indexPath) as! PostImageItem
        let imageMessage = posts[indexPath.section].message[indexPath.item] as! ImageMessage
        item.imageView?.image = nil
        imageMessage.getImage { image in
            item.imageView?.image = image
        }
        return item
    }
    
    /**
     Make a new PostGIFItem for the indexPath
     
     - parameter indexPath: Current indexPath
     
     - returns: The item
     */
    func gifCellForIndexPath(indexPath: NSIndexPath) -> PostGIFItem {
        let item = collectionView.makeItemWithIdentifier("GIFItem", forIndexPath: indexPath) as! PostGIFItem
        let imageMessage = posts[indexPath.section].message[indexPath.item] as! ImageMessage
        item.imageURL = imageMessage.src
        return item
    }
    
    /**
     Make a new PostVideoItem for the indexPath
     
     - parameter indexPath: Current indexPath
     
     - returns: The item
     */
    func videoCellForIndexPath(indexPath: NSIndexPath) -> PostVideoItem {
        let item = collectionView.makeItemWithIdentifier("videoItem", forIndexPath: indexPath) as! PostVideoItem
        let videoMessage = posts[indexPath.section].message[indexPath.item] as! VideoMessage
        item.videoURL = videoMessage.src
        return item
    }
    
    /**
     Make a new PostTextItem for the indexPath
     
     - parameter indexPath: Current indexPath
     
     - returns: The item
     */
    func musicCellForIndexPath(indexPath: NSIndexPath) -> PostTextItem {
        let item = collectionView.makeItemWithIdentifier("textItem", forIndexPath: indexPath) as! PostTextItem
        let musicMessage = posts[indexPath.section].message[indexPath.item] as! MusicMessage
        if let title = musicMessage.title {
            item.textLabel.stringValue = "\(title)"
        }
        return item
    }
    
    /**
     Make a new PostLocationItem for the indexPath
     
     - parameter indexPath: Current indexPath
     
     - returns: The item
     */
    func locationCellForIndexPath(indexPath: NSIndexPath) -> PostLocationItem {
        let item = collectionView.makeItemWithIdentifier("locationItem", forIndexPath: indexPath) as! PostLocationItem
        return item
    }
    
    /**
     Make a new PostLinkItem for the indexPath
     
     - parameter indexPath: Current indexPath
     
     - returns: The item
     */
    func linkCellForIndexPath(indexPath: NSIndexPath) -> PostLinkItem {
        let item = collectionView.makeItemWithIdentifier("linkItem", forIndexPath: indexPath) as! PostLinkItem
        return item
    }
    
}