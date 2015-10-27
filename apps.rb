packaged_apps = %w{
  pass
  wget
  tree
  gpg
  rbenv
  ruby-build
  node
}

packaged_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

dep 'all-packaged-apps' do
  requires *(packaged_apps).map { |a| "#{a}.bin" }
end
