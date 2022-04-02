# frozen_string_literal: true

class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> { where(is_private: false) }

  # Turbo
  after_create_commit { broadcast_append_to 'rooms' }
  # has_many :messages
end
