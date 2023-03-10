import Foundation
import PackagePlugin

@main
struct Plugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let openAPIDirectory = context.package.directory.appending("Sources", "OpenAPI")

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: openAPIDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            "app_store_connect_api_2.3_openapi.json",
            "--module", "AppStoreConnect_Swift_SDK",
            "--output", "Generated",
            "--config", ".create-api.yml",
            "--split",
            "--clean"
        ]

        try process.run()
        process.waitUntilExit()
    }
}
