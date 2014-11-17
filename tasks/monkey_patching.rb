require 'execjs/encoding'

module ExecJS
  module Encoding
    def encode(string)
      string.encoding == ::Encoding::UTF_8 ? string : string.encode(::Encoding::UTF_8)
    end
  end
end

if defined?(::Java)
  require 'java'
  java_version = Gem::Version.new(java.lang.System.getProperties['java.specification.version'])
  if java_version >= Gem::Version.new('1.8')
    require 'execjs/runtime'
    require 'multi_json'
    require 'execjs/module'

    module ExecJS
      class NashornRuntime < Runtime
        NASHORN = 'nashorn'.freeze

        class Context < Runtime::Context
          def initialize(runtime, source = '')
            @nashorn_context = javax.script.ScriptEngineManager.new.getEngineByName(NASHORN)

            exec source
          end

          def exec(source, options = nil)
            src = encode(source)

            unless src.empty?
              eval "(function(){#{src}})()"
            end
          end

          def eval(source, options = nil)
            src = encode(source)

            unless src.empty?
              MultiJson.load(@nashorn_context.eval("JSON.stringify([#{src}])"))[0]
            end
          rescue Java::JavaxScript::ScriptException => e
            if e.message =~ /^\<eval\>/
              raise RuntimeError, e.message
            else
              raise ProgramError, e.message
            end
          end

          def call(properties, *args)
            eval "#{properties}.apply(this, #{MultiJson::dump(args)})"
          end
        end

        def name
          'nashorn (Java 8)'
        end

        def available?
          true
        end
      end
    end

    require 'execjs/runtimes'

    module ExecJS
      module Runtimes
        Nashorn = NashornRuntime.new
        def self.runtimes
          @runtimes ||= [
            Nashorn,
            RubyRacer,
            RubyRhino,
            Johnson,
            Mustang,
            Node,
            JavaScriptCore,
            SpiderMonkey,
            JScript
          ]
        end
      end
    end
  end
end

require 'coffee_script'

module CoffeeScript
  module Source
    def self.contents
      return @contents if @contents
      wrapper = <<-JS
        ;function CompileCoffee(script, options) {
          try {
            return CoffeeScript.compile(script, options);
          } catch (err) {
            if (err instanceof SyntaxError && err.location) {
              throw new SyntaxError([
                err.filename || "[stdin]",
                err.location.first_line + 1,
                err.location.first_column + 1
              ].join(":") + ": " + err.message)
            } else {
              throw err;
            }
          }
        };
      JS

      @contents = File.read(path) + wrapper
    end
  end

  COMPILE_COFFEE = 'CompileCoffee'.freeze

  class << self
    def compile(script, options = {})
      script = script.read if script.respond_to?(:read)

      if options.key?(:bare)
      elsif options.key?(:no_wrap)
        options[:bare] = options[:no_wrap]
      else
        options[:bare] = false
      end

      Source.context.call(COMPILE_COFFEE, script, options)
    end
  end
end
