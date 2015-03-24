packaged_apps = %w{
  zsh
  vim
  ack
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
  requires *(packaged_apps).map { |a| "#{a}.bin" }
end
