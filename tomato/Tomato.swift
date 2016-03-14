//
//  Tomato.swift
//  Tomato
//
//  Created by Theo Phillips on 3/7/16.
//  Copyright © 2016 DurlApps. All rights reserved.
//

import Foundation

let tomatoKey = "TODO"

class Tomato {
    var name:String?
    var genre:String?
    var runtime:Int?
    var rating:String?
    var photoUrl:String?
    
    
    static func getTomatos(keyword:String,completion:(Array<Tomato>) ->()) {
        let urlString = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=\(tomatoKey)&q=\(keyword)&page_limit=10"
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {
            data, response, error in
            var array = Array<Tomato>()
            do {
                if data == nil {
                    completion(array)
                }
                else
                {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                    let jsonArray = jsonData["movies"] as! NSArray;
                    
                    for json in jsonArray {
                        let d = json as! NSDictionary
                        let t = Tomato()
                        t.rating = d.objectForKey("mpaa_rating") as! String?
                        t.runtime = d.objectForKey("runtime") as! Int?
                        t.name = d.objectForKey("title") as! String?
                        let photos = d.objectForKey("posters") as! NSDictionary
                        t.photoUrl = photos.objectForKey("detailed") as! String?
                        print(t.photoUrl!)
                        array.append(t)
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(array)
                    }
                }
            } catch {
                completion(array)
            }
        })
        task.resume()
    }
}