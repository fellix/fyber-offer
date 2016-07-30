require 'rails_helper'

describe Offer do
  describe '#to_s' do
    it "returns the offer's title" do
      subject = described_class.new(title: 'sample')

      expect(subject.to_s).to eq 'sample'
    end
  end
end
