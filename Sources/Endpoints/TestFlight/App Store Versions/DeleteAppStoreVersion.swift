extension APIEndpoint where T == Void {

    public static func delete(appStoreVersionWithId id: String) -> APIEndpoint {
        return APIEndpoint(path: "appStoreVersions/\(id)", method: .delete, parameters: nil)
    }
}
