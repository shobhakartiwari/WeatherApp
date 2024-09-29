//
//  NetworkProtocol.swift
//  WeatherApp
//
//  Created by Shobhakar on 9/23/24.
//

import Foundation
protocol NetworkManager : AnyObject {
    associatedtype T: Decodable
    func getDataFrom( _ serverUrl: String ) async throws -> T
}
