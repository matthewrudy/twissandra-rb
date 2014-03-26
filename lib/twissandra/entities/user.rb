module Twissandra

  class User

    # CREATE TABLE users (
    #   id       uuid,
    #   username text,
    #   location text,

    #   PRIMARY KEY (uuid)
    # );

    include Cequel::Record

    self.table_name = :users

    key    :id,       :uuid, auto: true
    column :username, :text
    column :location, :text

    # INSERT INTO users
    #   (id, username, location)
    # VALUES
    #   (?, ?, ?)
    # ;
    #

    # implemented by Cequel
    # def self.create(attributes)
    #   super(attributes)
    # end

    def self.create_with_username(username, user_hash)
      raise "username #{username.inspect} already in use" if find_by_username(username)

      create(user_hash.merge(username: username))
    end

  end
end
