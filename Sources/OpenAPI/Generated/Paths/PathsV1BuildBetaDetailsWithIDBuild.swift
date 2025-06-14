// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.BuildBetaDetails.WithID {
	public var build: Build {
		Build(path: path + "/build")
	}

	public struct Build {
		/// Path: `/v1/buildBetaDetails/{id}/build`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<AppStoreConnect_Swift_SDK.BuildResponse> {
			Request(path: path, method: "GET", query: parameters?.asQuery, id: "buildBetaDetails_build_getToOneRelated")
		}

		public struct GetParameters {
			public var fieldsBuilds: [FieldsBuilds]?
			public var fieldsPreReleaseVersions: [FieldsPreReleaseVersions]?
			public var fieldsBetaTesters: [FieldsBetaTesters]?
			public var fieldsBetaGroups: [FieldsBetaGroups]?
			public var fieldsBetaBuildLocalizations: [FieldsBetaBuildLocalizations]?
			public var fieldsAppEncryptionDeclarations: [FieldsAppEncryptionDeclarations]?
			public var fieldsBetaAppReviewSubmissions: [FieldsBetaAppReviewSubmissions]?
			public var fieldsApps: [FieldsApps]?
			public var fieldsBuildBetaDetails: [FieldsBuildBetaDetails]?
			public var fieldsAppStoreVersions: [FieldsAppStoreVersions]?
			public var fieldsBuildIcons: [FieldsBuildIcons]?
			public var fieldsBuildBundles: [FieldsBuildBundles]?
			public var include: [Include]?
			public var limitIndividualTesters: Int?
			public var limitBetaGroups: Int?
			public var limitBetaBuildLocalizations: Int?
			public var limitIcons: Int?
			public var limitBuildBundles: Int?

			public enum FieldsBuilds: String, Codable, CaseIterable {
				case version
				case uploadedDate
				case expirationDate
				case expired
				case minOsVersion
				case lsMinimumSystemVersion
				case computedMinMacOsVersion
				case computedMinVisionOsVersion
				case iconAssetToken
				case processingState
				case buildAudienceType
				case usesNonExemptEncryption
				case preReleaseVersion
				case individualTesters
				case betaGroups
				case betaBuildLocalizations
				case appEncryptionDeclaration
				case betaAppReviewSubmission
				case app
				case buildBetaDetail
				case appStoreVersion
				case icons
				case buildBundles
				case perfPowerMetrics
				case diagnosticSignatures
			}

			public enum FieldsPreReleaseVersions: String, Codable, CaseIterable {
				case version
				case platform
				case builds
				case app
			}

			public enum FieldsBetaTesters: String, Codable, CaseIterable {
				case firstName
				case lastName
				case email
				case inviteType
				case state
				case apps
				case betaGroups
				case builds
			}

			public enum FieldsBetaGroups: String, Codable, CaseIterable {
				case name
				case createdDate
				case isInternalGroup
				case hasAccessToAllBuilds
				case publicLinkEnabled
				case publicLinkID = "publicLinkId"
				case publicLinkLimitEnabled
				case publicLinkLimit
				case publicLink
				case feedbackEnabled
				case iosBuildsAvailableForAppleSiliconMac
				case iosBuildsAvailableForAppleVision
				case app
				case builds
				case betaTesters
				case betaRecruitmentCriteria
				case betaRecruitmentCriterionCompatibleBuildCheck
			}

			public enum FieldsBetaBuildLocalizations: String, Codable, CaseIterable {
				case whatsNew
				case locale
				case build
			}

			public enum FieldsAppEncryptionDeclarations: String, Codable, CaseIterable {
				case appDescription
				case createdDate
				case usesEncryption
				case exempt
				case containsProprietaryCryptography
				case containsThirdPartyCryptography
				case availableOnFrenchStore
				case platform
				case uploadedDate
				case documentURL = "documentUrl"
				case documentName
				case documentType
				case appEncryptionDeclarationState
				case codeValue
				case app
				case builds
				case appEncryptionDeclarationDocument
			}

			public enum FieldsBetaAppReviewSubmissions: String, Codable, CaseIterable {
				case betaReviewState
				case submittedDate
				case build
			}

			public enum FieldsApps: String, Codable, CaseIterable {
				case accessibilityURL = "accessibilityUrl"
				case name
				case bundleID = "bundleId"
				case sku
				case primaryLocale
				case isOrEverWasMadeForKids
				case subscriptionStatusURL = "subscriptionStatusUrl"
				case subscriptionStatusURLVersion = "subscriptionStatusUrlVersion"
				case subscriptionStatusURLForSandbox = "subscriptionStatusUrlForSandbox"
				case subscriptionStatusURLVersionForSandbox = "subscriptionStatusUrlVersionForSandbox"
				case contentRightsDeclaration
				case streamlinedPurchasingEnabled
				case accessibilityDeclarations
				case appEncryptionDeclarations
				case ciProduct
				case betaTesters
				case betaGroups
				case appStoreVersions
				case preReleaseVersions
				case betaAppLocalizations
				case builds
				case betaLicenseAgreement
				case betaAppReviewDetail
				case appInfos
				case appClips
				case appPricePoints
				case endUserLicenseAgreement
				case appPriceSchedule
				case appAvailabilityV2
				case inAppPurchases
				case subscriptionGroups
				case gameCenterEnabledVersions
				case perfPowerMetrics
				case appCustomProductPages
				case inAppPurchasesV2
				case promotedPurchases
				case appEvents
				case reviewSubmissions
				case subscriptionGracePeriod
				case customerReviews
				case customerReviewSummarizations
				case gameCenterDetail
				case appStoreVersionExperimentsV2
				case alternativeDistributionKey
				case analyticsReportRequests
				case marketplaceSearchDetail
				case backgroundAssets
				case betaFeedbackScreenshotSubmissions
				case betaFeedbackCrashSubmissions
				case webhooks
			}

			public enum FieldsBuildBetaDetails: String, Codable, CaseIterable {
				case autoNotifyEnabled
				case internalBuildState
				case externalBuildState
				case build
			}

			public enum FieldsAppStoreVersions: String, Codable, CaseIterable {
				case platform
				case versionString
				case appStoreState
				case appVersionState
				case copyright
				case reviewType
				case releaseType
				case earliestReleaseDate
				case usesIdfa
				case downloadable
				case createdDate
				case app
				case ageRatingDeclaration
				case appStoreVersionLocalizations
				case build
				case appStoreVersionPhasedRelease
				case gameCenterAppVersion
				case routingAppCoverage
				case appStoreReviewDetail
				case appStoreVersionSubmission
				case appClipDefaultExperience
				case appStoreVersionExperiments
				case appStoreVersionExperimentsV2
				case customerReviews
				case alternativeDistributionPackage
			}

			public enum FieldsBuildIcons: String, Codable, CaseIterable {
				case iconAsset
				case iconType
				case name
			}

			public enum FieldsBuildBundles: String, Codable, CaseIterable {
				case bundleID = "bundleId"
				case bundleType
				case sdkBuild
				case platformBuild
				case fileName
				case hasSirikit
				case hasOnDemandResources
				case hasPrerenderedIcon
				case usesLocationServices
				case isIosBuildMacAppStoreCompatible
				case includesSymbols
				case dSYMURL = "dSYMUrl"
				case supportedArchitectures
				case requiredCapabilities
				case deviceProtocols
				case locales
				case entitlements
				case baDownloadAllowance
				case baMaxInstallSize
				case appClipDomainCacheStatus
				case appClipDomainDebugStatus
				case betaAppClipInvocations
				case buildBundleFileSizes
			}

			public enum Include: String, Codable, CaseIterable {
				case preReleaseVersion
				case individualTesters
				case betaGroups
				case betaBuildLocalizations
				case appEncryptionDeclaration
				case betaAppReviewSubmission
				case app
				case buildBetaDetail
				case appStoreVersion
				case icons
				case buildBundles
			}

			public init(fieldsBuilds: [FieldsBuilds]? = nil, fieldsPreReleaseVersions: [FieldsPreReleaseVersions]? = nil, fieldsBetaTesters: [FieldsBetaTesters]? = nil, fieldsBetaGroups: [FieldsBetaGroups]? = nil, fieldsBetaBuildLocalizations: [FieldsBetaBuildLocalizations]? = nil, fieldsAppEncryptionDeclarations: [FieldsAppEncryptionDeclarations]? = nil, fieldsBetaAppReviewSubmissions: [FieldsBetaAppReviewSubmissions]? = nil, fieldsApps: [FieldsApps]? = nil, fieldsBuildBetaDetails: [FieldsBuildBetaDetails]? = nil, fieldsAppStoreVersions: [FieldsAppStoreVersions]? = nil, fieldsBuildIcons: [FieldsBuildIcons]? = nil, fieldsBuildBundles: [FieldsBuildBundles]? = nil, include: [Include]? = nil, limitIndividualTesters: Int? = nil, limitBetaGroups: Int? = nil, limitBetaBuildLocalizations: Int? = nil, limitIcons: Int? = nil, limitBuildBundles: Int? = nil) {
				self.fieldsBuilds = fieldsBuilds
				self.fieldsPreReleaseVersions = fieldsPreReleaseVersions
				self.fieldsBetaTesters = fieldsBetaTesters
				self.fieldsBetaGroups = fieldsBetaGroups
				self.fieldsBetaBuildLocalizations = fieldsBetaBuildLocalizations
				self.fieldsAppEncryptionDeclarations = fieldsAppEncryptionDeclarations
				self.fieldsBetaAppReviewSubmissions = fieldsBetaAppReviewSubmissions
				self.fieldsApps = fieldsApps
				self.fieldsBuildBetaDetails = fieldsBuildBetaDetails
				self.fieldsAppStoreVersions = fieldsAppStoreVersions
				self.fieldsBuildIcons = fieldsBuildIcons
				self.fieldsBuildBundles = fieldsBuildBundles
				self.include = include
				self.limitIndividualTesters = limitIndividualTesters
				self.limitBetaGroups = limitBetaGroups
				self.limitBetaBuildLocalizations = limitBetaBuildLocalizations
				self.limitIcons = limitIcons
				self.limitBuildBundles = limitBuildBundles
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsBuilds, forKey: "fields[builds]")
				encoder.encode(fieldsPreReleaseVersions, forKey: "fields[preReleaseVersions]")
				encoder.encode(fieldsBetaTesters, forKey: "fields[betaTesters]")
				encoder.encode(fieldsBetaGroups, forKey: "fields[betaGroups]")
				encoder.encode(fieldsBetaBuildLocalizations, forKey: "fields[betaBuildLocalizations]")
				encoder.encode(fieldsAppEncryptionDeclarations, forKey: "fields[appEncryptionDeclarations]")
				encoder.encode(fieldsBetaAppReviewSubmissions, forKey: "fields[betaAppReviewSubmissions]")
				encoder.encode(fieldsApps, forKey: "fields[apps]")
				encoder.encode(fieldsBuildBetaDetails, forKey: "fields[buildBetaDetails]")
				encoder.encode(fieldsAppStoreVersions, forKey: "fields[appStoreVersions]")
				encoder.encode(fieldsBuildIcons, forKey: "fields[buildIcons]")
				encoder.encode(fieldsBuildBundles, forKey: "fields[buildBundles]")
				encoder.encode(include, forKey: "include")
				encoder.encode(limitIndividualTesters, forKey: "limit[individualTesters]")
				encoder.encode(limitBetaGroups, forKey: "limit[betaGroups]")
				encoder.encode(limitBetaBuildLocalizations, forKey: "limit[betaBuildLocalizations]")
				encoder.encode(limitIcons, forKey: "limit[icons]")
				encoder.encode(limitBuildBundles, forKey: "limit[buildBundles]")
				return encoder.items
			}
		}
	}
}
