class User < ApplicationRecord
  enum role: [:admin, :partner, :contributor]

  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
end
