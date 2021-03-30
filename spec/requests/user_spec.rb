require "rails_helper"

RSpec.describe User, :type => :request do
  let(:user) { create(:user, :admin) }
  let(:headers) { { "Authorization": sign_in(user) } }
  let(:target_user) { create(:user) }

  it "creates a User" do
    post users_path, params: { user: attributes_for(:user) }, headers: headers

    expect(response).to have_http_status(:created)
  end

  it "updates a User" do
    expected_email = "target_user@email.com"
    patch user_path(target_user), params: { user: { email: expected_email } }, headers: headers

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["email"]).to eq(expected_email)
  end

  it "destroy a User" do
    delete user_path(target_user), headers: headers

    expect(response).to have_http_status(:ok)
    expect(User.all.count).to be(1)
  end

  it "shows a User" do
    get user_path(target_user), headers: headers

    expect(response).to have_http_status(:ok)
  end

  it "get Users" do
    create(:user)
    get users_path, headers: headers

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).count).to be(1)
  end
end
