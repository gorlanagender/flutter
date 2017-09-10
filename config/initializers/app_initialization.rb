puts '*******  Starting Application Initialization!!! ********'
ENV_PROPS = Services::AppStartupService.new.set_env_properties(config_path: 'config/env_props.yml', env: Rails.env)
puts '*******  Initialization Completed *********'
