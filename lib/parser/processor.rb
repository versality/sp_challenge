module Parser
  class Processor
    def initialize(log_path)
      @log_records = []
      process_logs(log_path)
    end

    def formattable
      Formatter.new(record_collection)
    end

    def record_collection
      LogRecordCollection.new(@log_records)
    end

    private
    def process_logs(log_path)
      File.open(log_path, 'r') do |f|
        f.each_line do |line|
          instantiate_log_record(line)
        end
      end
    end

    def instantiate_log_record(raw_log_record)
      @log_records << LogRecord.new(*raw_log_record.split)
    end
  end
end
