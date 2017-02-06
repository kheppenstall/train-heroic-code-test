require 'spec_helper'

describe 'Coach free trial' do
  context 'creates an account' do
    context 'adds a new team' do
      it 'visits calendar page for that team' do
        coach = Coach.new
        team  = coach.team

        visit '/app/signup/ch#/welcome'

        coach.start_free_trial

        expect(find('h3')).to have_content 'No Teams'
        expect(current_path).to eq '/admin/coach'

        coach.create_team
        coach.view_calendar_when_active

        expect(page).to have_css '#calendar-programs', visible: false
      end
    end
  end
end
