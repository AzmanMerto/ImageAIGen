//
//  APICaller.swift
//  ImageAIGen
//
//  Created by NomoteteS on 20.12.2022.
//

import SwiftUI
import OpenAIKit

final class APICaller: ObservableObject {
    private var openai: OpenAI?
    
    func setup() {
        openai = OpenAI(Configuration(
            organization: "NomoteteS",
            apiKey: "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"
        ))
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        guard let openai = openai else { return nil }
        
        do {
            let params = ImageParameters(
                                         prompt: prompt,
                                         resolution: .medium,
                                         responseFormat: .base64Json)
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            let image = try  openai.decodeBase64Image(data)
            return image
        } catch {
            print(String(describing: error))
            return nil
        }
    }
}
