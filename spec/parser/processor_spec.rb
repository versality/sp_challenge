require 'spec_helper'

RSpec.describe Parser::Processor do
  subject { described_class.new('spec/fixtures/webserver.log') }

  describe '#record_collection' do
    it 'returns LogRecordCollection' do
      expect(subject.record_collection).to be_an_instance_of(Parser::LogRecordCollection)
    end
  end

  describe '#formattable' do
    it 'returns Formatter' do
      expect(subject.formattable).to be_an_instance_of(Parser::Formatter)
    end
  end
end