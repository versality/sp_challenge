module Parser
  class Formatter
    def initialize(log_records)
      @log_records = log_records
    end

    def call(opts)
      self.send(opts)
    end

    def summary
      most_visits
      most_visits_uniq
    end

    def most_visits
      puts "\n"
      puts "> list of webpages with most page views ordered from most pages views to less page views".yellow

      records_visits = @log_records
        .group_by(:path)
        .sort(:desc)
        .records

      records_visits.each do |path, records|
        puts "\t#{path} #{records.size.to_s.red} visits"
      end
    end

    def most_visits_uniq
      puts "\n"
      puts "> list of webpages with most unique page views also ordered".yellow
      visits_uniq = @log_records
        .group_by(:path)
        .uniq(:ip_address)
        .sort(:desc)
        .records

      visits_uniq.each do |path, records|
        puts "\t#{path} #{records.size.to_s.red} unique views"
      end
    end
  end
end
