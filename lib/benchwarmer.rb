class Benchwarmer
  attr_reader :results

  class << self
    def run(options = {gc: :enable})
      if options[:gc] == :disable
        GC.disable
      elsif options[:gc] == :enable
        # collect memory allocated during library loading
        # and our own code before the measurement
        GC.start
      end

      memory_before = memory_snapshot

      gc_stat_before = GC.stat
      time = Benchmark.realtime do
        yield
      end

      gc_stat_after = GC.stat
      GC.start if options[:gc] == :enable

      memory_after = memory_snapshot

      new(
          {
              ruby_version: RUBY_VERSION,
              time: time.round(2),
              gc: options[:gc],
              gc_count_after: gc_stat_after[:count].to_i,
              gc_count_before: gc_stat_before[:count].to_i,
              memory_after: memory_after,
              memory_before: memory_before
          }
      )
    end

    private

    def memory_snapshot
      `ps -o rss= -p #{Process.pid}`.to_i/1024
    end
  end


  def initialize(results)
    @results = results
  end

  def gc
    @results[:gc]
  end

  def time(round_by:2)
    @results[:time].round(round_by)
  end

  def gc_count
    @results[:gc_count_after] - @results[:gc_count_before]
  end

  def ruby_version
    @results[:ruby_version]
  end

  def memory
    @results[:memory_after] - @results[:memory_before]
  end

  def save_report(location:nil, name:, format: nil)

    location = location.nil? ? "#{Rails.root}/benchmarks" : "#{Rails.root}/#{location}"
    output = print_report(format: format)
    extension = format == :json ? 'json' : 'txt'
    file_name = "#{name}.#{extension}"

    File.open("#{location}/#{file_name}", "w+") do |f|
      f.puts output
    end
  end

  def report
    {
        ruby_version: ruby_version,
        gc: gc.to_s,
        time: time,
        gc_count: gc_count,
        memory: "%d MB" % memory
    }
  end

  def print_report(format: nil)
    return "Please choose :json, :text" unless [:json, :text, nil].include?(format)
    return text_report unless format == :json
    json_report
  end

  private

  def text_report
    printed_report = ""
    report.each { |k, v| printed_report << "#{k}: #{report.fetch(k)} " }
    printed_report
  end

  def json_report
    report.to_json
  end


end