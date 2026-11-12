require 'test/unit'
require 'open3'

class TestJRubyOpen3 < Test::Unit::TestCase
  def test_process_builder_selection
    source = File.expand_path('../lib/open3.rb', __dir__)
    [[false, nil, false], [true, nil, true], [false, true, false],
     [true, true, false], [false, false, true], [true, false, true]].each do |windows, native, expected|
      script = <<~RUBY
        module JRuby
          module Util
            remove_const(:ON_WINDOWS)
            ON_WINDOWS = #{windows}
            singleton_class.send(:remove_method, :native_popen?) if respond_to?(:native_popen?)
            #{"def self.native_popen?; #{native}; end" unless native.nil?}
          end
        end
        module Kernel
          alias original_require require
          def require(path)
            if path == 'open3/jruby'
              $process_builder_selected = true
              return true
            end
            original_require(path)
          end
        end
        load #{source.dump}
        abort 'wrong fallback selection' unless !!$process_builder_selected == #{expected}
      RUBY
      stdout, stderr, status = Open3.capture3(EnvUtil.rubybin, '-e', script)
      assert_equal('', stdout)
      assert_equal('', stderr)
      assert_predicate(status, :success?)
    end
  end
end if RUBY_ENGINE == 'jruby'
