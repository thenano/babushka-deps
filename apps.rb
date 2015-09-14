packaged_apps = %w{
  pass
  wget
  tree
  gpg
}

packaged_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end
