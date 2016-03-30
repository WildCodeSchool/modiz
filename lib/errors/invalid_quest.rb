require_relative 'error_message'

module Modiz
  class InvalidQuest < Exception
    class Standard < StandardError
      def initialize *wrong_line
        @wrong_line = wrong_line
      end

      def message
        message = InvalidQuest.load_messages(self.to_s)
        message + concat_wrong_lines
      end

      def concat_wrong_lines
        @wrong_line.join(', ')
      end
    end

    def self.load_messages klass
      Modiz.error_messages[klass.split('::').last.to_sym]
    end

    class NoStepDelimiter           < Standard; end
    class NoChallengeDelimiter      < Standard; end
    class NoStepsContent            < Standard; end
    class NoChallengeContent        < Standard; end
    class NoQuestTitle              < Standard; end
    class NoQuestObjectives         < Standard; end
    class NoQuestDescription        < Standard; end
    class NoChallengeTitle          < Standard; end
    class NoChallengeCriteriaMarkup < Standard; end
    class NoChallengeDescription    < Standard; end
    class NoChallengeCriteria       < Standard; end
    class NoStepTitle               < Standard; end
    class InvalidLink               < Standard; end
    class DoubleLineMissing         < Standard; end
  end
end
