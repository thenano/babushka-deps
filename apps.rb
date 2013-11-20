packaged_apps = %w{
  zsh
  vim
  ack
  pass
  wget
  nethack
  tree
}

packaged_apps_alt_provides = {
  "leiningen" => ["lein"],
  "sqlite" => ["sqlite3"],
  "macvim" => ["mvim"]
}

packaged_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

packaged_apps_alt_provides.each do |app, ps|
  dep "#{app}.bin" do
    installs app
    provides ps
  end
end

dep 'all-packaged-apps' do
  requires *(packaged_apps + packaged_apps_alt_provides.keys).map { |a| "#{a}.bin" }
end
