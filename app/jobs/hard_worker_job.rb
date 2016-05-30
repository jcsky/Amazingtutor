class HardWorkerJob < ActiveJob::Base
  queue_as :default

  def perform(msg)
    # Do something later
    Rails.logger.debug("------test JOB: start")
    puts("rertwer")
    sleep(10)

    Rails.logger.debug("------test JOB: #{msg}")

  end
end
