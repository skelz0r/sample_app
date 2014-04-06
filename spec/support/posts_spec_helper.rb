module PostsSpecHelper

  def create_post_at(time)
    micropost = attributes_for(:micropost)
    #micropost[:created_at] = time
    @user.microposts.create!(micropost)
  end

end

RSpec.configure do |config|
  config.include PostsSpecHelper, :type => :request
end
