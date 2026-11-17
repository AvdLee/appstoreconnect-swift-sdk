import Foundation
import PackagePlugin

@main
struct Plugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")

        let process = Process()
        // Package@swift-5.7.swift uses Plugins/CreateAPILegacy, which keeps the `Path` API of older tools versions.
        process.currentDirectoryURL = context.package.directoryURL.appending(components: "Sources", "OpenAPI")
        process.executableURL = createAPI.url
        process.arguments = [
            "generate",
            "app_store_connect_api.json",
            "--output", "Generated",
            "--config", "create-api.yml",
            "--clean"
        ]

        try process.run()
        process.waitUntilExit()
    }
}
