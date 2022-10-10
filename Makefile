# Downloads latest spec and Regenerates source code
.PHONY: update
update: download generate

# Grabs the latest spec and perform some manual coersion to fix errors
# see https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/197
.PHONY: download
download:
	curl -fsSL -o - https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip | bsdtar -xOf - | jq '.components.schemas.BundleIdPlatform.enum |= [ "IOS", "MAC_OS", "UNIVERSAL" ] | del(.["x-important"]) | del(.. |."enum"? | select(. != null and length == 0))' > Sources/OpenAPI/app_store_connect_api_2.0_openapi.json

# Runs the CreateAPI generator to update generated source code
.PHONY: generate
generate:
	swift package --allow-writing-to-package-directory generate-open-api
