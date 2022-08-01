import Foundation
import PackagePlugin

@main
struct Plugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let currentDirectoryURL =  URL(fileURLWithPath: context.package.directory.string)
            .appendingPathComponent("Sources")
            .appendingPathComponent("OpenAPI")

        let process = Process()
        process.currentDirectoryURL = currentDirectoryURL
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            "app_store_connect_api_2.0_openapi.json",
            "--module", "AppStoreConnect_Swift_SDK",
            "--output", ".",
            "--config", ".create-api.yml",
            "--split"
        ]

        try process.run()
        process.waitUntilExit()
    }
}
