config_file_path = "#{Rails.root}/config/base_configs.yml"
if File.exists?(config_file_path)
  file_contents = File.read(config_file_path)
  BASE_CONFIGS = file_contents.strip.blank? ? {} : YAML.load(file_contents).symbolize_keys
else
  BASE_CONFIGS = {}
end