# == Schema Information
#
# Table name: admins
#
#  id                  :integer          not null, primary key
#  email               :string(255)      default(""), not null
#  encrypted_password  :string(255)      default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_admins_on_email  (email) UNIQUE
#

require 'rails_helper'

describe Admin do
  before do
    @admin = Admin.new(email: 'raderj89@gmail.com', password: 'password',
                       password_confirmation: 'password')
  end

  subject { @admin }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

end
