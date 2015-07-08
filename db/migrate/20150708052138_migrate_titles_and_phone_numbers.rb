class MigrateTitlesAndPhoneNumbers < Mongoid::Migration
  def self.up
  	Contact.all.each do |c|
  		c.save!
  	end
  end

  def self.down
  end
end