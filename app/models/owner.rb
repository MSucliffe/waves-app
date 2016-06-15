class Owner < ActiveRecord::Base
  ALLOWED_NATIONALITIES = [
    "GB"
  ].freeze

  SUGGESTED_TITLES = [
    "Mr",
    "Mrs",
    "Miss",
    "Ms",
    "Doctor",
    "Reverant"
  ].freeze

  has_many :owner_addresses
  has_many :addresses, through: :owner_addresses

  has_many :owner_vessels
  has_many :vessels, through: :owner_vessels

  belongs_to :address
  accepts_nested_attributes_for :address

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates(
    :nationality,
    presence: true,
    format: { with: /\A[A-Z]{2}\z/ },
    inclusion: { in: ALLOWED_NATIONALITIES }
  )

  validates_email_format_of :email

  validates :mobile_number, presence: true
end
