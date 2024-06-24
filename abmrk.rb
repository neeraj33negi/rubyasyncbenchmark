require_relative "bmrk"
require "async"
require "async/barrier"

class Abmrk < Bmrk
  def start_performing(count)
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
end
