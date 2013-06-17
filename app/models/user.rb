class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:twitter, :facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :avatar, :password_confirmation, :remember_me, :provider, :uid, :name
  # attr_accessible :title, :body
  attr_reader :avatar_remote_url

  attr_accessor :login

  attr_accessible :login

  validates_presence_of :username
  validates_uniqueness_of :username

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.lastname = auth.info.last_name
      user.firstname = auth.info.first_name
      user.avatar_from_url = auth.info.image
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  def avatar_remote_url=(url_value)
    self.avatar = URI.parse(url_value)
    @avatar_remote_url = url_value
  end

end