gems_to_install = %w{

  tmuxinator
  zeus
  bundler

}

gems_to_install.each do |gem|
  gem_package gem do
    action :install
    ignore_failure true
  end
end
