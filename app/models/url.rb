class Url < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  before_save :check_save
  validates :long_url, :format => URI::regexp(%w(http https))

  def check_save
    self.click_count ||= 0
    self.short_url ||= [*0..9, *'A'..'Z'].sample(7).join
  end

end
