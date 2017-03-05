class Measure
  attr_reader :results

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

  def print_report
    ap({
        ruby_version: RUBY_VERSION,
        gc: gc,
        time: time,
        gc_count: gc_count,
        memory: "%d MB" % memory
    })
  end

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



end