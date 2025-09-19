# Downloads latest spec and Regenerates source code
.PHONY: update
update: download generate

# Grabs the latest spec and perform some manual coersion to fix errors
# see https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/197
.PHONY: download
download:
	curl -fsSL -o - https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip | bsdtar -xOf - | jq '.components.schemas.BundleIdPlatform.enum |= [ "IOS", "MAC_OS", "UNIVERSAL", "SERVICES" ] | del(.["x-important"]) | del(.. |."enum"? | select(. != null and length == 0)) | .components.schemas.AppEvent.properties.attributes.properties.deepLink.format = null | .components.schemas.AppEvent.properties.attributes.properties.deepLink.type = "string"' > Sources/AppStoreConnectApi/OpenAPI/app_store_connect_api.json
	for patch in Sources/AppStoreConnectApi/OpenAPI/patches/spec/*.patch; do \
		patch -p1 < "$$patch"; \
	done

	curl -fsSL -o - http://developer.apple.com/sample-code/enterprise/enterprise-program-openapi-oas.zip | bsdtar -xOf - > Sources/AppStoreConnectEnterpriseApi/OpenAPI/app_store_connect_api.json

# Runs the CreateAPI generator to update generated source code
.PHONY: generate
generate:
	swift package --allow-writing-to-package-directory generate-open-api
	for patch in Sources/AppStoreConnectApi/OpenAPI/patches/generated/*.patch; do \
		patch -p1 < "$$patch"; \
	done
