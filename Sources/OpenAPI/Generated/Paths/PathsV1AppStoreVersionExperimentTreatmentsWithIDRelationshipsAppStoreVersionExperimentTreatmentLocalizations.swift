// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.AppStoreVersionExperimentTreatments.WithID.Relationships {
	public var appStoreVersionExperimentTreatmentLocalizations: AppStoreVersionExperimentTreatmentLocalizations {
		AppStoreVersionExperimentTreatmentLocalizations(path: path + "/appStoreVersionExperimentTreatmentLocalizations")
	}

	public struct AppStoreVersionExperimentTreatmentLocalizations {
		/// Path: `/v1/appStoreVersionExperimentTreatments/{id}/relationships/appStoreVersionExperimentTreatmentLocalizations`
		public let path: String
	}
}
