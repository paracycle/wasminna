require 's_expression_parser'

def main
  unless ARGV.empty?
    s_expression = SExpressionParser.new.parse(ARGF.read)
    Interpreter.new.interpret(s_expression)
  end
end

class Interpreter
  Function = Struct.new(:name, :body, keyword_init: true)

  def interpret(script)
    functions = []

    script.each do |command|
      case command
      in ['module', *expressions]
        expressions.each do |expression|
          case expression
          in ['func', ['export', name], ['result', _], body]
            functions << Function.new(name:, body:)
          end
        end
      in ['assert_return', ['invoke', name], ['i32.const', expected_value]]
        function = functions.detect { |function| function.name == name }
        raise "couldn’t find function #{name}" if function.nil?
      in ['assert_malformed', *]
        # TODO
      end
    end
  end
end

main
