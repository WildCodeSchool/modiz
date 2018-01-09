module Modiz
  class ChallengeBuilder < ModizBuilder
    def initialize(quest_lines)
      @lines = quest_lines
      validations
    end

    attr_reader :to_hash

    def to_hash
      {      title: title,
       description: description,
          criteria: criterias }
    end

    private

    def title
      remove_markup @lines[title_index]
    end

    def description
      @lines[title_index + 1...criterias_index].join.strip
    end

    def criterias
      Modiz.listify @lines[criterias_index + 1..-1]
    end

    def remove_markup string
      string[/\w(.*)$/].strip
    end

    def include_bullet_point string
      string.match(/\*(.*)|\+(.*)|\-(.*)$/)
    end

    def title_index
      @lines.find_index { |line| /\A###\s/.match(line) }
    end

    def criterias_index
      @lines.find_index { |line| /\A### Crit/.match(line) }
    end

    def validations
      raise InvalidQuest::NoChallengeTitle unless title_index
      raise InvalidQuest::NoChallengeCriteriaMarkup unless criterias_index
      raise InvalidQuest::NoChallengeDescription if description.empty?
      raise InvalidQuest::NoChallengeCriteria if criterias.empty?
    end
  end
end
