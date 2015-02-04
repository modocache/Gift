require_relative "helpers.rb"

desc "Updates all the dependencies required to build libssh2 and libgit2"
task :dependencies => [
  "dependencies:homebrew",
  "dependencies:cmake",
  "dependencies:submodules",
  "dependencies:reactivecocoa"
]

namespace :dependencies do
  desc "Update homebrew"
  task :homebrew do
    `brew update`
  end

  desc "Upgrade the cmake installed by homebrew"
  task :cmake do
    `brew upgrade cmake`
  end

  desc "Downloads and updates all Git submodules used by this project"
  task :submodules do
    run "git submodule update --init --recursive"
  end

  desc "Run the ReactiveCocoa setup script"
  task :reactivecocoa do
    run "cd External/ReactiveCocoa && script/bootstrap"
  end
end

