# Downloads latest spec and Regenerates source code
.PHONY: update
update: download generate

# CI check for updates to the spec
.PHONY: ci-check
ci-check: download generate check push

# Grabs the latest spec and perform some manual coersion to fix errors
# see https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/197
.PHONY: download
download:
	curl -fsSL -o - https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip | bsdtar -xOf - | jq '.components.schemas.BundleIdPlatform.enum |= [ "IOS", "MAC_OS", "UNIVERSAL", "SERVICES" ] | .paths."/v1/certificates".get.parameters = (.paths."/v1/certificates".get.parameters | map(if .name == "filter[certificateType]" then .schema.items.enum += ["DEVELOPER_ID_APPLICATION_G2"] else . end)) | .components.schemas.CertificateType.enum += ["DEVELOPER_ID_APPLICATION_G2"] | del(.["x-important"]) | del(.. |."enum"? | select(. != null and length == 0))' > Sources/OpenAPI/app_store_connect_api.json

# Runs the CreateAPI generator to update generated source code
.PHONY: generate
generate:
	swift package --allow-writing-to-package-directory generate-open-api

# Check for updates to the spec and regenerate source code
.PHONY: check
check: ./check_for_updates.sh

# Commit and push the updated spec
.PHONY: push
push:
	git switch --create spec-update-$$NEW_VERSION
	git commit -m "[ci skip] Update spec to $$NEW_VERSION"
	git push origin spec-update-$$NEW_VERSION