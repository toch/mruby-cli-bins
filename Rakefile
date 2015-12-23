SUPPORTED_TARGET = {
  "linux" => "x86_64-pc-linux-gnu",
  "osx" => "x86_64-apple-darwin14",
  "win" => "x86_64-w64-mingw32"
}
def test_bin_for_target(target)
  abort "target not supported" unless SUPPORTED_TARGET.keys.include? target
  bin = "#{SUPPORTED_TARGET[target]}/bin/mruby-cli"
  bin << ".exe" if target == "win"
  abort "mruby for target #{target} absent!" unless File.exists? bin
  `#{bin}`
  abort "#{target} target is not runnable" unless $?.success?
  puts "#{target} target is working!"
end

def detect_os_name
  return ENV["TRAVIS_OS_NAME"] if ENV.key? "TRAVIS_OS_NAME"
  return "win" if ENV.key? "APPVEYOR"
  "unknown"
end

desc "test on the current target its corresponding binary"
task :test do
  test_bin_for_target detect_os_name
end

task :default => [:test]
