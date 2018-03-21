packaged_apps = %w{
  wget
  tree
  gpg
  rbenv
  ruby-build
  nvm
  git
  pyenv
}

packaged_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

dep 'blackbox.bin' do
  installs 'blackbox'
  provides 'blackbox_initialize'
end

dep 'all-packaged-apps' do
  requires *(packaged_apps).map { |a| "#{a}.bin" }
  requires 'bash-completion.bin'
  requires 'blackbox.bin'
end

dep 'bash-completion.bin' do
  met? {
    (shell('brew --prefix') + '/etc/bash_completion').p.exists?
  }

  installs 'bash-completion'
end
