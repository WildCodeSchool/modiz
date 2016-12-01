module Modiz
  class QuestBuilder < Builder
    attr_reader :to_hash

    def initialize(quest_lines)
      @lines = quest_lines
      validations
    end

    def to_hash
      {       title: title,
        description: description,
              goals: goals }
    end

    private

    def title
      @lines.first.tr("#", "").strip
    end

    def goals
      Modiz.listify @lines[goal_index + 1...-1]
    end

    def description
      @lines[1...goal_index].join.strip
    end

    def goal_index
      @lines.index {|s| s.include?("## Objectifs")}
    end

    def validations
      raise InvalidQuest::NoQuestTitle if title.empty?
      raise InvalidQuest::NoQuestObjectives if goals.empty?
      raise InvalidQuest::NoQuestDescription if description.empty?
    end
  end
end
