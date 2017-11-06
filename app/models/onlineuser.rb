# frozen_string_literal: true
class Onlineuser < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }
end
