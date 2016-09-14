require 'rails_helper'

RSpec.describe Organisation::LanguagesController, type: :controller do

  describe '#update' do
    subject { patch :update, language: {locale: :de} }
    before { allow(controller.request).to receive(:referer).and_return('http://example.com') }

    it { is_expected.to redirect_to(request.referer) }
  end
end
