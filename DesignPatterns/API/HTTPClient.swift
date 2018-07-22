//
//  HTTPClient.swift
//  DesignPatterns
//
//  Created by Matt Deuschle on 7/22/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class HTTPClient {

    @discardableResult func getRequest(_ url: String) -> AnyObject {
        return Data() as AnyObject
    }

    @discardableResult func postRequest(_ url: String, body: String) -> AnyObject {
        return Data() as AnyObject
    }

    func downloadImage(_ url: String) -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
}
