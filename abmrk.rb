require_relative "bmrk"
require "async"
require "async/barrier"
require "async/semaphore"

class Abmrk < Bmrk
  def start_performing(count)
    perform_unbounded(count)
  end

  private def perform_unbounded(count)
    barrier = Async::Barrier.new

    Async do
      count.times do
        barrier.async do
          task
        end
      end
    end
    barrier.wait
  end

  ## fix this
  private def perform_bounded(count)
    barrier = Async::Barrier.new
    semaphore = Async::Semaphore.new(4, parent: barrier)

    Async do
      count.times do
        semaphore.async(parent: barrier) do
          task
        end
      end
    end
    barrier.wait
  end
end
