//
//  GameSearch.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class GameSearch: MagicInputHandler {
    
    override func handleAction(input: String) {
        
        Alamofire.request(.GET, "https://api.twitch.tv/kraken/search/games", parameters: ["q": input, "type": "suggest"])
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    if let games = json["games"].array {
                        if games.count > 0 {
                            var attachment: NSTextAttachment!
                            if games.count > 1 {
                                let options = games.map { return "🎮 \($0["name"].string!)" }
                                attachment = PeachTextOptionsAttachment(options: options, textView: self.textView)
                            } else {
                                let string = "🎮 \(games[0]["name"].string!)"
                                attachment = PeachTextAttachment(string: string, textView: self.textView)
                            }
                            self.delegate?.appendComplexAttachment(attachment)
                        }
                    }
                }
            }
        
    }
    
}