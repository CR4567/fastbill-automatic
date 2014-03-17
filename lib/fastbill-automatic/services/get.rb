module Fastbill
  module Automatic
    module Services
      module Get
        module ClassMethods

          def get(filter = {}, limit = 20, offset = 0)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.get", filter, limit, offset)
            results_from(response)
          end

          private
          def results_from(response)
            results = []
            response["RESPONSE"]["#{self.name.split("::").last.upcase}S"].each do |obj|
              results << self.new(obj)
            end
            results
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end