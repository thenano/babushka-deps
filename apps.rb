packaged_apps = %w{
  pass
  wget
  tree
  gpg
  rbenv
  ruby-build
  nvm
  git
}

packaged_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

dep 'all-packaged-apps' do
  requires *(packaged_apps).map { |a| "#{a}.bin" }
  requires 'bash-completion.bin'
end

dep 'bash-completion.bin' do
  met? {
    (shell('brew --prefix') + '/etc/bash_completion').p.exists?
  }

  installs 'bash-completion'
end
