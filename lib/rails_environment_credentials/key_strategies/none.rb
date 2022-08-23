# frozen_string_literal: true

module RailsEnvironmentCredentials
  module KeyStrategies

    class None < Base; end

    add(nil, None)

  end
end
