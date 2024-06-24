require_relative "bmrk"
require "concurrent-ruby"

class Crbmrk < Bmrk
  include Concurrent::Async

  def start_performing(count)
    using_promises(count)
  end

  ## figure out way to wait for all tasks without blocking the main thread
  private def using_async(count)
    count.times do
      async.task
    end
  end

  private def using_promises(count)
    requests = Concurrent::Array.new
    count.times do
      requests << Concurrent::Promise.execute { task }
    end
    Concurrent::Promise.all?(requests).execute.wait
  end
end
