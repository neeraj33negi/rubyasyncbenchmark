class Bmrk
  def perform_for(count)
    start_performing count
  end

  def task
    sleep 0.3
    # puts "Performed task from #{self.class.name}"
  end

  def perform_sync(count)
    count.times do
      task
    end
  end
end
