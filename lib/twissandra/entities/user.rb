module Twissandra

  class User

    # CREATE TABLE users (
    #   uuid     uuid,
    #   username text,
    #   location text,

    #   PRIMARY KEY (uuid)
    # );

    include Cequel::Record

    self.table_name = :users

    key    :uuid,     :uuid, auto: true
    column :username, :text
    column :location, :text

    # INSERT INTO users
    #   (uuid, username, location)
    # VALUES
    #   (?, ?, ?)
    # ;
    #

    # implemented by Cequel
    # def self.create(attributes)
    #   super(attributes)
    # end

  end
end
