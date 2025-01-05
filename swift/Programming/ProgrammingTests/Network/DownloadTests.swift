//
//  DownloadTests.swift
//  Programming
//
//  Created by ke on 1/5/25.
//

import Testing
import Foundation

struct DownloadTests {
    @Test
    func testDownload() async throws {
        var data: Data = Data()
        
        do {
            data = try await Download.download(fileName: "mario")
        } catch {
            print(error)
        }
        
        if let content = String(data: data, encoding: .utf8) {
            print(content)
        }
    }
}
