import Foundation
import PackagePlugin

@main
struct Plugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        try generate(context: context, specFile: "app_store_connect_api.json", target: "AppStoreConnectApi")
        try generate(context: context, specFile: "app_store_connect_api.json", target: "AppStoreConnectEnterpriseApi")
    }

    private func generate(context: PluginContext, specFile: String, target: String) throws {
        let createAPI = try context.tool(named: "create-api")
        let openAPIDirectory = context.package.directory.appending("Sources", target, "OpenAPI")

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: openAPIDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            specFile,
            "--output", "Generated",
            "--config", "create-api.yml",
            "--clean"
        ]

        try process.run()
        process.waitUntilExit()
    }
}
