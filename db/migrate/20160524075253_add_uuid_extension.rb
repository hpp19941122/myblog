# frozen_string_literal: true

class AddUuidExtension < ActiveRecord::Migration[6.0]
  def change
    enable_extension "pgcrypto"
  end
end
