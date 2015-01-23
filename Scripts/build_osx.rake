require_relative "helpers.rb"

LIBGIT2_INSTALL_PATH = File.expand_path("../External/libgit2/build/libgit2.a", File.dirname(__FILE__))

namespace "build" do
  desc "Build libssh2 and libgit2 for OS X"
  task :osx => ["build:osx:libssh2", "build:osx:libgit2"]

  namespace :osx do
    desc "Upgrade the version of libssh2 installed by homebrew"
    task :libssh2 do
      `brew upgrade libssh2`
    end

    desc "Build libgit2.a for OS X"
    task :libgit2 do
      if File.exist? LIBGIT2_INSTALL_PATH
        puts "libgit2.a already exists at \"#{LIBGIT2_INSTALL_PATH}\""
        next
      end

      run <<-command
        mkdir -p External/libgit2/build && \\
        cd External/libgit2/build && \\
        cmake -DBUILD_SHARED_LIBS:BOOL=OFF -DBUILD_CLAR:BOOL=OFF -DTHREADSAFE:BOOL=ON ..
        cmake --build .
      command
    end
  end
end

