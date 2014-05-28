packaged_apps = %w{
  zsh
  vim
  ack
  pass
  wget
  tree
  gpg
  emacs
}

packaged_apps_alt_provides = {
  "leiningen" => ["lein"],
  "sqlite" => ["sqlite3"]
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

dep "homebrew-games" do
  met? {
    shell("brew tap").include? "homebrew/games"
  }

  meet {
    shell("brew tap homebrew/games")
  }
end

games = %w{
  nethack
}

games.each do |app, ps|
  dep "#{app}.bin" do
    requires "homebrew-games"
    installs app
    provides ps
  end
end

dep 'all-packaged-apps' do
  requires *(packaged_apps + packaged_apps_alt_provides.keys).map { |a| "#{a}.bin" }
end
