# -*- encoding : utf-8 -*-
require File.expand_path('spec/spec_helper.rb')





describe "Saulabs::TrueSkill::ScoreBasedBayesianRating: series of games" do




  describe "#team1 wins in 60% of all cases}" do
    #Erzeuge Gaussverteilung

    percentage = 0.5
    #team1 = [TrueSkill::Rating.new(50, 25.0/3.0, 1.0, 0.01),TrueSkill::Rating.new(10.0, 25.0/3.0, 1.0, 0.01)]
    #team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 0.01),TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 0.01)]
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 0.0),TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 0.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 0.0)]
    gamma = 60
    beta = 20

    for i in 0..2000
      u = Random.rand()
      v = Random.rand()
      z1 = Math.sqrt(-2 * Math.log(u)) * Math.sin(2 * 3.14159265 * v)
      val = Random.rand()
      if val < percentage
        price = (z1*gamma).abs
      else
        price = -(z1*gamma).abs
      end
      results = {team1 => price, team2 => -price }
      #puts "#{results.inspect}"
      TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => gamma, :beta => beta, :skills_additive => false}).update_skills
    end
  end

end




