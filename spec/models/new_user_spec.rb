describe NewUser do
  subject { NewUser.new(user: 1, access_token: 2) }

  it { should be_valid }
  it { should respond_to(:user) }
  it { should respond_to(:access_token) }
end
