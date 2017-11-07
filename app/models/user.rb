class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
	has_many :articles
	 # devise :database_authenticatable, :registerable,
  #    :recoverable, :rememberable, :trackable, :validatable

	before_save {self.email = email.downcase}

	validates :username, presence: true,
			   uniqueness: {case_sensitive: false},
			   length: {minimum: 3, maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true,
			   uniqueness: {case_sensitive: false}, length: { maximum: 105 },
			   format: { with: VALID_EMAIL_REGEX}

	has_secure_password 

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }#, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  	has_attached_file :document
	validates_attachment :document, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }


	
	def validate_email
		self.email_confirmed = true
		self.confirmation_token = nil
	end


	
	
	def confirm_token
      if self.confirmation_token.blank?
          self.confirmation_token = SecureRandom.urlsafe_base64
          flash = self.confirmation_token
      end
    end


end


