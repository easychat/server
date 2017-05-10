class User < ApplicationRecord
  include UuidHelper
  def serializable_hash(options = {})
    result = super(options.merge({only: ["email", "uuid"]}))
    result
  end
end
