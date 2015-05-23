require_relative '../spec_helper'

describe 'User Model' do

  let(:current_user) {User.create(name: 'Remy', location: 'Lebeau', email: 'gambit@xmen.com', password: plaintext_password)}
  let(:plaintext_password) { 'opensesame' }

  context 'Users Password' do
    it 'Should have a password_hash' do
      expect(current_user.attributes).to include( 'password_hash' )
    end

    it 'Should have a password' do
      expect(current_user.methods).to include( :password )
    end

    it 'Should not allow an empty password' do
      expect(current_user.password).to_not be( nil )
    end

    it 'Should not be a plaintext password' do
     expect(current_user.password).to_not be( plaintext_password )
    end

    it 'Should have an authenticate method' do
      expect(current_user.methods).to include( :authenticate )
    end

    it 'Should authenticate with a plaintext password' do
      expect(current_user.authenticate(plaintext_password)).to be(true)
    end
  end

end
