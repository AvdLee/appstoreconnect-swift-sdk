extension APIEndpoint where T == Void {

    /// Delete an app store version that is associated with an app.
    ///
    /// # Reference
    /// [Apple Documentation](https://developer.apple.com/documentation/appstoreconnectapi/delete_an_app_store_version)
    public static func delete(appStoreVersionWithId id: String) -> APIEndpoint {
        return APIEndpoint(path: "appStoreVersions/\(id)", method: .delete, parameters: nil)
    }
}
