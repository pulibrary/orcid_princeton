# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrcidsController do
  let(:user_with_orcid) { FactoryBot.create(:user_with_orcid) }
  let(:user) { FactoryBot.create(:user, orcid: nil) }
  let(:omniauth_hash) do
    OmniAuth::AuthHash.new(credentials:, uid: user_with_orcid.orcid)
  end
  let(:credentials) do
    OmniAuth::AuthHash.new(
      expires: true,
      expires_at: 2_329_292_554,
      refresh_token: "4daad3c0-5bcd-4d39-b505-a515b32d2f87",
      token: "253e5364-eb30-4cbb-83be-3e5c9ce3b0bc"
    )
  end

  before do
    # set up the environment to have the aminauth hash
    @request.env["omniauth.auth"] = omniauth_hash
  end

  it "creates the token from omniauth" do
    sign_in user
    expect(user.orcid).to be_nil
    expect { get :create }.to change { Token.count }.by(1)
    expect(user.reload.orcid).to eq(user_with_orcid.orcid)
    expect(response).to redirect_to(user_path(user))
  end
end
