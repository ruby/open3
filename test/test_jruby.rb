require 'test/unit'
require 'open3'

class TestJRubyOpen3 < Test::Unit::TestCase
  def test_process_builder_selection
    source = File.expand_path('../lib/open3.rb', __dir__)
    [[false, nil, false], [true, nil, true], [false, true, false],
     [false, false, true], [true, false, true]].each do |windows, native, expected|
      script = <<~RUBY
        Object.send(:remove_const, :RUBY_ENGINE)
        RUBY_ENGINE = 'jruby'
        module JRuby
          module Util
            ON_WINDOWS = #{windows}
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
      assert_in_out_err(['-e', script], '', [], [], success: true)
    end
  end
end
