class Syncer
  def initialize(token, secret)
    @token = token
    @secret = secret
  end

  def sync!(user)

  end

  private

  def client
    Dropbox.new @token, @secret
  end
end
