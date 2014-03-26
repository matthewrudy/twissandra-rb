module Twissandra
  class CreateUser
    def perform(user_hash)

      # * store User details
      user = User.create(user_hash)

      # return the user we created
      {user: user}
    end
  end
end
