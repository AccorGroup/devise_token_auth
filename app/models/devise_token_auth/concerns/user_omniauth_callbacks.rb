module DeviseTokenAuth::Concerns::UserOmniauthCallbacks
  extend ActiveSupport::Concern

  included do
    validates :email, presence: true, email: true
    validates :uid,   presence: true
    validates :email, uniqueness: { scope: :provider }
    validates :uid,   uniqueness: { scope: :provider }

    # keep uid in sync with email
    before_validation :sync_uid
    before_save       :sync_uid
  end

  protected

  def sync_uid
    self.uid = email if provider == 'email'
  end
end
