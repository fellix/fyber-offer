require 'rails_helper'

describe App do
  describe '#to_s' do
    it 'returns the app name' do
      subject = described_class.new(app_name: 'sample')

      expect(subject.to_s).to eq 'sample'
    end
  end
end
