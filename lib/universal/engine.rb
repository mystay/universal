module Universal
  if defined?(Rails)
    class Engine < ::Rails::Engine
      isolate_namespace Universal
    end
  end
end
