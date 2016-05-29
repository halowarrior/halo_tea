require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'ffi-compiler/compile_task'
require 'rake'

task :default => [ :compile_ffi, :spec]

desc "clean, make and run specs"
task :spec  do
  RSpec::Core::RakeTask.new
end

desc "FFI compiler"
namespace "ffi-compiler" do
  FFI::Compiler::CompileTask.new("./ext/halo_pck_algo") do |ct|

  end
end
task :compile_ffi => ["ffi-compiler:default"]
