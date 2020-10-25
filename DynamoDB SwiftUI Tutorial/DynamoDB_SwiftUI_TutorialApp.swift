//
//  DynamoDB_SwiftUI_TutorialApp.swift
//  DynamoDB SwiftUI Tutorial
//
//  Created by Francesco Dal Savio on 24/10/2020.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct DynamoDB_SwiftUI_TutorialApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    func configureAmplify() {
        do {
            try Amplify.add(
                plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels())
            )
            try Amplify.configure()
            print("Amplify initialized")

        } catch {
            print("could not initialize Amplify - \(error)")
        }
    }
}
