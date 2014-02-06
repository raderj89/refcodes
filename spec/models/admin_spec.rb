require 'spec_helper'

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
