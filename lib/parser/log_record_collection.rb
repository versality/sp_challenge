module Parser
  LogRecord = Struct.new(:path, :ip_address)

  class LogRecordCollection
    attr_accessor :records

    def initialize(log_records)
      @log_records = log_records
      @records     = []
    end

    def sort(order=:desc)
      @records = if order == :desc
        @records.sort_by { |k, v| v.size }.reverse
      else
        @records.sort_by { |k, v| v.size }
      end
      self
    end

    def uniq(attr)
      @records = @records.map do |k, v| 
        [
          k, 
          v.map(&attr).uniq
        ]
      end
      self
    end

    def group_by(attr)
      group_records(attr)
      self
    end

    private
    def group_records(attr)      
      @records = @log_records
        .group_by { |entry| entry.send(attr) }
    end
  end
end
