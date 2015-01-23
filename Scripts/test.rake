require_relative "helpers.rb"

desc "Test the Gift-iOS and Gift-OSX targets"
task :test => ["test:ios", "test:osx"]

namespace :test do
  desc "Test the Gift-iOS target"
  task :ios do
    run "xcodebuild -workspace Gift.xcworkspace -scheme Gift-iOS test"
  end

  desc "Test the Gift-OSX target"
  task :osx do
    run "xcodebuild -workspace Gift.xcworkspace -scheme Gift-OSX test"
  end
end

