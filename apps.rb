packaged_apps = %w{
  wget
  tree
  gpg
  rbenv
  ruby-build
  pyenv
}

packaged_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

dep 'git.bin' do
  met? {
    shell('$(brew --prefix git)/bin/git --version')
  }

  installs 'git'
end

dep 'nvm.bin' do
  met? {
    shell('brew --prefix nvm').p.exists?
  }

  installs 'nvm'
end

dep 'blackbox.bin' do
  installs 'blackbox'
  provides 'blackbox_initialize'
end

dep 'bash-completion.bin' do
  met? {
    (shell('brew --prefix') + '/etc/bash_completion').p.exists?
  }

  installs 'bash-completion'
end

dep 'all-packaged-apps' do
  requires *(packaged_apps).map { |a| "#{a}.bin" }
  requires 'bash-completion.bin'
  requires 'blackbox.bin'
  requires 'nvm.bin'
  requires 'git.bin'
end
