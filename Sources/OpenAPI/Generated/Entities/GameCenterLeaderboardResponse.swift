// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct GameCenterLeaderboardResponse: Codable {
	/// GameCenterLeaderboard
	public var data: GameCenterLeaderboard
	public var included: [IncludedItem]?
	public var links: DocumentLinks

	public enum IncludedItem: Codable {
		case gameCenterDetail(GameCenterDetail)
		case gameCenterGroup(GameCenterGroup)
		case gameCenterLeaderboard(GameCenterLeaderboard)
		case gameCenterLeaderboardSet(GameCenterLeaderboardSet)
		case gameCenterLeaderboardLocalization(GameCenterLeaderboardLocalization)
		case gameCenterLeaderboardRelease(GameCenterLeaderboardRelease)
		case gameCenterActivity(GameCenterActivity)
		case gameCenterChallenge(GameCenterChallenge)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(GameCenterDetail.self) {
				self = .gameCenterDetail(value)
			} else if let value = try? container.decode(GameCenterGroup.self) {
				self = .gameCenterGroup(value)
			} else if let value = try? container.decode(GameCenterLeaderboard.self) {
				self = .gameCenterLeaderboard(value)
			} else if let value = try? container.decode(GameCenterLeaderboardSet.self) {
				self = .gameCenterLeaderboardSet(value)
			} else if let value = try? container.decode(GameCenterLeaderboardLocalization.self) {
				self = .gameCenterLeaderboardLocalization(value)
			} else if let value = try? container.decode(GameCenterLeaderboardRelease.self) {
				self = .gameCenterLeaderboardRelease(value)
			} else if let value = try? container.decode(GameCenterActivity.self) {
				self = .gameCenterActivity(value)
			} else if let value = try? container.decode(GameCenterChallenge.self) {
				self = .gameCenterChallenge(value)
			} else {
				throw DecodingError.dataCorruptedError(
					in: container,
					debugDescription: "Data could not be decoded as any of the expected types (GameCenterDetail, GameCenterGroup, GameCenterLeaderboard, GameCenterLeaderboardSet, GameCenterLeaderboardLocalization, GameCenterLeaderboardRelease, GameCenterActivity, GameCenterChallenge)."
				)
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .gameCenterDetail(let value): try container.encode(value)
			case .gameCenterGroup(let value): try container.encode(value)
			case .gameCenterLeaderboard(let value): try container.encode(value)
			case .gameCenterLeaderboardSet(let value): try container.encode(value)
			case .gameCenterLeaderboardLocalization(let value): try container.encode(value)
			case .gameCenterLeaderboardRelease(let value): try container.encode(value)
			case .gameCenterActivity(let value): try container.encode(value)
			case .gameCenterChallenge(let value): try container.encode(value)
			}
		}
	}

	public init(data: GameCenterLeaderboard, included: [IncludedItem]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: StringCodingKey.self)
		self.data = try values.decode(GameCenterLeaderboard.self, forKey: "data")
		self.included = try values.decodeIfPresent([IncludedItem].self, forKey: "included")
		self.links = try values.decode(DocumentLinks.self, forKey: "links")
	}

	public func encode(to encoder: Encoder) throws {
		var values = encoder.container(keyedBy: StringCodingKey.self)
		try values.encode(data, forKey: "data")
		try values.encodeIfPresent(included, forKey: "included")
		try values.encode(links, forKey: "links")
	}
}
