class Register::ShareholderGroupMember < ApplicationRecord
  belongs_to :owner
  belongs_to :shareholder_group
end
