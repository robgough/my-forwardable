require 'my_forwardable'

describe MyForwardable do

  let(:records) { %w(oasis blur beatles) }
  let(:collection) { RecordCollection.new(records) }

  it 'delegates single methods' do
    expect( collection.size ).to eq(records.size)
  end

  it 'delegates methods with a different name' do
    expect( collection.record_number(2) ).to eq(records[2])
  end

  it 'delegates multiple methods' do
    collection << 'new order'
    result = collection.map(&:upcase)

    expect( result ).to eq(["OASIS", "BLUR", "BEATLES", "NEW ORDER"])
  end

  class RecordCollection
    extend MyForwardable

    attr_reader :records

    def_delegator  :records, :size
    def_delegator  :records, :[], :record_number

    def_delegators :records, :<<, :map

    def initialize(records)
      @records = records
    end

  end
end
