module Services
  class AppStartupService
    def set_env_properties(config_path:, env: Rails.env)
      env_path = Rails.root.join(config_path)
      env_yaml = ERB.new(env_path.read).result
      YAML.load(env_yaml)[env]
    end
  end
end