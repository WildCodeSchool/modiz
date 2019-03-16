require 'modiz/resources_builder'

module Modiz
  class StepsBuilder < ModizBuilder
    attr_reader :to_hash, :step

    def initialize step
      @step = step
    end

    def to_hash
      {       title: title,
        description: description,
          resources: resources }
    end

    private

    def split_on_resource
      if step.include?("#### Ressources")
        step.split("#### Ressources")
      else
        step.split("#### Resources")
      end
    end

    def resources
      if step.match Modiz.title_hashtags 4
        ResourcesBuilder.new(split_on_resource.last).to_hash
      else
        nil
      end
    end

    def title
      @title ||= step.split(double_line).first[/\w(.*)$/]
    end

    def description
      desc = split_on_resource.first.split(double_line)
      desc.shift
      desc.join(double_line)
    end

    def double_line
      if step.include?("\n\n")
        @double_line ||= "\n\n"
      else
        @double_line ||= "\r\n"
      end
    end
  end
end
