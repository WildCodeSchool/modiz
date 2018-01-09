require 'modiz/resources_builder'

module Modiz
  class StepBuilder < ModizBuilder
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
      step.split("#### Ressources")
    end

    def resources
      if step.match Modiz.title_hashtags 4
        ResourcesBuilder.new(split_on_resource.last).to_hash
      else
        nil
      end
    end

    def title
      step.split(double_line).first[/\w(.*)$/]
    end

    def description
      desc = split_on_resource.first.split(double_line)
      desc.shift
      desc.join(double_line)
    end

    def double_line
      "\n\n"
    end
  end
end
