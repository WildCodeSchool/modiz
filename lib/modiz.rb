require 'logger'
require 'modiz/version'
require 'modiz/modiz_builder'
require 'modiz/quest_builder'
require 'modiz/steps_builder'
require 'modiz/challenge_builder'
require 'modiz/errors/invalid_quest'
require 'modiz/validator'

module Modiz
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new($stdout).tap do |log|
        log.progname = self.name
      end
    end

    def listify string
      string.join.split(%r{\n\s*\*})
            .map(&:strip)
            .reject(&:empty?)
    end

    def title_hashtags size
      hashtags = '#' * size
      "\n#{hashtags} "
    end
  end

  class Parser
    def initialize quest_file
      @file_content = quest_file
      validate_markdown_quest_format
    end

    def self.run quest_file
      new(quest_file).to_quest
    end

    def to_quest
      #Modiz.logger.debug "---------------"
      #Modiz.logger.debug steps_wrapper
      {     quest_details: QuestBuilder.run(quest_lines),
                    steps: steps_wrapper,
        challenge_details: ChallengeBuilder.run(challenge_lines) }
    end

    private

    def validate_markdown_quest_format
      validation_arguments = {
        file: @file_content,
        steps_index: steps_index,
        challenge_index: challenge_index,
        steps_lines: steps_lines,
        challenge_lines: challenge_lines
      }
      Validator.run validation_arguments
    end

    def steps_wrapper
      #Modiz.logger.debug "-----"
      steps = steps_lines.join.strip.split(Modiz.title_hashtags(3)).reject(&:empty?)
      #Modiz.logger.debug steps
      steps.map do |step|
        StepsBuilder.run step
      end
    end

    def quest_lines
      lines_of 0...steps_index
    end

    def steps_lines
      lines_of steps_index + 1...challenge_index if steps_index && challenge_index
    end

    def challenge_lines
      lines_of challenge_index..-1 if challenge_index
    end

    def steps_index
      steps_index = find_index '## Etapes'
      steps_index ||= find_index '## Steps'
      steps_index
    end

    def challenge_index
      find_index '## Challenge'
    end

    def lines_of section
      @file_content.lines[section]
    end

    def find_index section
      @file_content.lines.index {|s| s.include?(section)}
    end
  end
end
