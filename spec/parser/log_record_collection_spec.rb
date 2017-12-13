require 'spec_helper'

LogRecord = Struct.new(:path, :ip_address)

RSpec.describe Parser::LogRecordCollection do
  subject do
    records = [
      Parser::LogRecord.new('path1', '111.222.333.444'),
      Parser::LogRecord.new('path2', '222.222.333.444'),
      Parser::LogRecord.new('path2', '222.222.333.444'),
      Parser::LogRecord.new('path3', '333.222.333.444'),
    ]
    
    described_class.new(records)
  end

  describe '#group_by' do
    it 'has correct number of records' do
      records = subject.group_by(:path).records
      expect(records.size).to eq 3
    end

    it 'throws NoMethodError on wrong attribute' do
      expect{ subject.group_by(:wrong_attribute) }.to raise_error(NoMethodError)
    end

    it 'is grouped_by' do
      expect(subject.group_by(:path).records).to be_an_instance_of(Hash)
    end
  end

  describe '#sort' do
    it 'returns sorted collection' do
      records = subject.group_by(:path).sort.records
      expect(records.first.first).to eq 'path2'
    end
  end

  describe '#uniq' do
    it 'returns uniq collection' do
      records = subject.group_by(:path).uniq(:ip_address).records
      expect(records[1].size).to eq 2
    end
  end

  context 'chaining' do
    describe '#group_by' do
      it 'returns LogRecordCollection instance' do
        expect(subject.group_by(:path)).to be_an_instance_of(described_class)
        expect(subject.group_by(:ip_address)).to be_an_instance_of(described_class)
      end
    end
  end
end