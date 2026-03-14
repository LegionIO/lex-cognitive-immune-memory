# frozen_string_literal: true

module Legion
  module Extensions
    module CognitiveImmuneMemory
      class Client
        include Runners::CognitiveImmuneMemory

        def initialize
          @default_engine = Helpers::ImmuneMemoryEngine.new
        end
      end
    end
  end
end
