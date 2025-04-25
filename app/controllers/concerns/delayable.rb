module Delayable
  extend ActiveSupport::Concern

  included do
    before_action -> { sleep(rand(0.1..1.0)) }
  end
end
