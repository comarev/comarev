require 'rails_helper'

describe User, type: :request do
  describe 'post /users/password' do
    context 'with valid email' do
      subject(:send_password_reset_email) do
        post user_password_path, params: { user: {email: user.email}, format: :json}
      end

      let(:user) { create(:user) }

      before do
        send_password_reset_email
      end
      
      it 'returns the correct 200 response code' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct message' do
        expect(json[:message]).to eq('Reset password email was successfully sent')
      end

      it 'sends reset password instructions email' do
        expect(ActionMailer::Base.deliveries.count(1))
      end

      it 'sends the correct email' do
        ActionMailer::Base.deliveries.first.subject.should == 'Instruções de troca de senha'
      end
    end
    context 'with invalid email' do
      subject(:send_password_reset_email_invalid) do
        post user_password_path, params: { user: { }, format: :json}
      end

      before do
        send_password_reset_email_invalid
      end
      
      it 'returns the correct 200 response code' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns the correct message' do
        expect(json[:message]).to eq('Reset password email could not be sent')
      end

      it "Doesn't send reset password instructions email" do
        expect(ActionMailer::Base.deliveries.count(0))
      end
    end
  end
end
