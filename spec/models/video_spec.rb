require 'rails_helper'

RSpec.describe Video, type: :model do
  context "validations" do
    context "presence" do
      it { should validate_presence_of :titulo }
      it { should validate_presence_of :url }
    end
  end
end
