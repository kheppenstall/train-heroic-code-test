require 'spec_helper'

describe 'Coach free trial' do
  context 'creates an account' do
    context 'adds a new team' do
      it 'visits calendar page for that team' do

        coach = FreeTrialCoach.new
        visit '/app/signup/ch#/welcome'

        coach.start_free_trial

        # expect(page).to have_content 'No Teams'
        # expect(current_path).to eq '/admin/coach'

        coach.create_team

        # expect(page).to have_content coach.team.name
        # expect(current_path).to eq '/app/signup/ch'



        # coach.view_calendar

        # expect(page).to have_content
        # expect(current_path).to eq 

      end
    end
  end
end