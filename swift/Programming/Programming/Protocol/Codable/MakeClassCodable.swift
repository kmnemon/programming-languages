//
//  MakeClassCodable.swift
//  Programming
//
//  Created by ke Liu on 12/30/25.
//
import Foundation

struct URLWrapper: Codable {
    let value: URL

    init(_ value: URL) {
        self.value = value
    }

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlString = try container.decode(String.self, forKey: .value)

        guard let url = URL(string: urlString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .value,
                in: container,
                debugDescription: "Invalid URL string"
            )
        }

        self.value = url
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value.absoluteString, forKey: .value)
    }
}


func exampleOfWrapperCodable() {
    let original = URLWrapper(URL(string: "https://example.com")!)

    do {
        let data = try JSONEncoder().encode(original)
        print(String(data: data, encoding: .utf8)!)
        // {"value":"https://example.com"}
        
        let decoded = try JSONDecoder().decode(URLWrapper.self, from: data)
        print(decoded.value)
        // https://example.com
    } catch {
        print(error.localizedDescription)
    }
}
