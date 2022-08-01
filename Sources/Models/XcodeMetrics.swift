//
//  PerfPowerMetrics.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Huy Vo on 1/8/22.
//

import Foundation

// The data structure that represents xcodemetrics.
// https://developer.apple.com/documentation/appstoreconnectapi/xcodemetrics
public struct XcodeMetrics: Codable {
	public var version: String?
	public var insights: Insights?
	public var productData: [ProductDatum]?

	public struct Insights: Codable {
		public var trendingUp: [MetricsInsight]?
		public var regressions: [MetricsInsight]?

		public init(trendingUp: [MetricsInsight]? = nil, regressions: [MetricsInsight]? = nil) {
			self.trendingUp = trendingUp
			self.regressions = regressions
		}
	}

	public struct ProductDatum: Codable {
		public var platform: String?
		public var metricCategories: [MetricCategory]?

		public final class MetricCategory: Codable {
			public let identifier: AppStoreConnect_Swift_SDK.MetricCategory?
			public let metrics: [Metric]?

			public struct Metric: Codable {
				public var identifier: String?
				public var goalKeys: [GoalKey]?
				public var unit: Unit?
				public var datasets: [Dataset]?

				public struct GoalKey: Codable {
					public var goalKey: String?
					public var lowerBound: Int?
					public var upperBound: Int?

					public init(goalKey: String? = nil, lowerBound: Int? = nil, upperBound: Int? = nil) {
						self.goalKey = goalKey
						self.lowerBound = lowerBound
						self.upperBound = upperBound
					}
				}

				public struct Unit: Codable {
					public var identifier: String?
					public var displayName: String?

					public init(identifier: String? = nil, displayName: String? = nil) {
						self.identifier = identifier
						self.displayName = displayName
					}
				}

				public struct Dataset: Codable {
					public var filterCriteria: FilterCriteria?
					public var points: [Point]?

					public struct FilterCriteria: Codable {
						public var percentile: String?
						public var device: String?
						public var deviceMarketingName: String?

						public init(percentile: String? = nil, device: String? = nil, deviceMarketingName: String? = nil) {
							self.percentile = percentile
							self.device = device
							self.deviceMarketingName = deviceMarketingName
						}
					}

					public struct Point: Codable {
						public var version: String?
						public var value: Double?
						public var errorMargin: Double?
						public var percentageBreakdown: PercentageBreakdown?
						public var goal: String?

						public struct PercentageBreakdown: Codable {
							public var value: Double?
							public var subSystemLabel: String?

							public init(value: Double? = nil, subSystemLabel: String? = nil) {
								self.value = value
								self.subSystemLabel = subSystemLabel
							}
						}

						public init(version: String? = nil, value: Double? = nil, errorMargin: Double? = nil, percentageBreakdown: PercentageBreakdown? = nil, goal: String? = nil) {
							self.version = version
							self.value = value
							self.errorMargin = errorMargin
							self.percentageBreakdown = percentageBreakdown
							self.goal = goal
						}
					}

					public init(filterCriteria: FilterCriteria? = nil, points: [Point]? = nil) {
						self.filterCriteria = filterCriteria
						self.points = points
					}
				}

				public init(identifier: String? = nil, goalKeys: [GoalKey]? = nil, unit: Unit? = nil, datasets: [Dataset]? = nil) {
					self.identifier = identifier
					self.goalKeys = goalKeys
					self.unit = unit
					self.datasets = datasets
				}
			}

			public init(identifier: AppStoreConnect_Swift_SDK.MetricCategory? = nil, metrics: [Metric]? = nil) {
				self.identifier = identifier
				self.metrics = metrics
			}
		}

		public init(platform: String? = nil, metricCategories: [MetricCategory]? = nil) {
			self.platform = platform
			self.metricCategories = metricCategories
		}
	}

	public init(version: String? = nil, insights: Insights? = nil, productData: [ProductDatum]? = nil) {
		self.version = version
		self.insights = insights
		self.productData = productData
	}
}