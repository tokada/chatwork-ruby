module ChatWork
  module Operations
    def install_class_operations(*operations)
      define_create if operations.include?(:create)
      define_get if operations.include?(:get)
    end

    def define_get
      instance_eval do
        def get(params = {})
          convert(ChatWork.client.get(path, params))
        end
      end
    end

    def define_create
      instance_eval do
        def create(params = {})
          # TODO: Consider other pattern
          # /rooms and /rooms/:room_id
          assign_path = if params.include?(:room_id)
            path % params.delete(:room_id)
          else
            path
          end
          convert(ChatWork.client.post(assign_path, params))
        end
      end
    end
  end
end
