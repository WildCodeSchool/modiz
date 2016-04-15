module Modiz
  class Validator
    def initialize inputs
      @quest_file = inputs[:file]
      @steps_index = inputs[:steps_index]
      @challenge_index = inputs[:challenge_index]
      @steps_lines = inputs[:steps_lines]
      @challenge_lines = inputs[:challenge_lines]
      validate_links

      validate_file_structure
      validate_file_content
      validate_no_step_title
    end

    def self.run inputs
      new inputs
    end

    private

    def validate_links
      invalid_urls = every_urls.map do |url|
        valid_format?(url) ? nil : url
      end.compact
      raise InvalidQuest::InvalidLink.new invalid_urls.join(', ') if invalid_urls.any?
    end

    def validate_file_structure
      raise InvalidQuest::NoStepDelimiter unless @steps_index
      raise InvalidQuest::NoChallengeDelimiter unless @challenge_index
    end

    def validate_file_content
      raise InvalidQuest::NoStepsContent if @steps_lines.join.strip.empty?
      raise InvalidQuest::NoChallengeContent if @challenge_lines.join.strip == "## Challenge"
    end

    def validate_no_step_title
      raise InvalidQuest::NoStepTitle.new(@steps_index) unless @steps_lines.to_s.scan("### ").any?
    end

    def wrong_lines_index title_part
      @quest_file.lines.map do |line|
        @quest_file.lines.index(line) if line.include?(title_part.lines.last)
      end.compact.join(', ')
    end

    def every_urls
      @quest_file.lines.map{|url| url.scan(/]\(([^)]+)\)/)}.flatten
    end

    def valid_format? url
      url.match(/https?:\/\/[\S]+/) ? true : false
    end
  end
end
