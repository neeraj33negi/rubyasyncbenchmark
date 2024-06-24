require_relative "abmrk"
require_relative "crbmrk"
require 'benchmark-memory'
require 'benchmark'

class Application
  def benchmark(count)
    puts "Time usage -----------------------------------------"
    Benchmark.bm do |x|
      x.report("Aync:")  { async_ruby(count) }
      x.report(("Concurrent:") ) { concurrent_ruby(count) }
    end

    puts "\n\n\nMemory usage -----------------------------------------"
    Benchmark.memory do |x|
      x.report("Aync:")  { async_ruby(count) }
      x.report(("Concurrent:") ) { concurrent_ruby(count) }
    end
  end

  def async_ruby(i)
    Abmrk.new.start_performing(i)
  end

  def concurrent_ruby(i)
    Crbmrk.new.start_performing(i)
  end

  def run_abmrk
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    Abmrk.new.start_performing(10)
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "Async Time took: #{t1 - t0} seconds.\n\n"

    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    Abmrk.new.perform_sync(10)
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "Async Time took: #{t1 - t0} seconds."
  end

  def run_crbmrk
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    Crbmrk.new.start_performing(10)
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "Async Time took: #{t1 - t0} seconds.\n\n"

    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    Crbmrk.new.perform_sync(10)
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "Async Time took: #{t1 - t0} seconds."
  end
end

Application.new.benchmark(ARGV[0].to_i)
# Application.new.run_abmrk
# Application.new.run_crbmrk
