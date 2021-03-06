# -*- coding: utf-8 -*-
class Team
  def initialize(name)
    raise ArgumentError if name == nil
    @team_name = name
  end

  attr_reader :team_name

  def new_runner
    Runner.new self
  end
end
