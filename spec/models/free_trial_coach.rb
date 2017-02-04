class FreeTrialCoach
  include Capybara::DSL

  attr_reader :full_name,
              :username,
              :email,
              :password,
              :phone,
              :organization_name,
              :team

  def initialize
    first_name          = Faker::Name.first_name

    @full_name          = first_name + Faker::Name.last_name
    @username           = unique(first_name)
    @email              = Faker::Internet.safe_email(username)
    @password           = Faker::Internet.password
    @phone              = '999-999-9999'
    @organization_name  = unique(Faker::University.name)
    @team               = Team.new
  end

  def start_free_trial
    fill_in 'fullName',   with: full_name
    fill_in 'username',   with: username
    fill_in 'email',      with: email
    fill_in 'password',   with: password
    fill_in 'phone',      with: phone
    fill_in 'newOrgName', with: organization_name

    click_on 'Start Your Free Trial'
  end

  def create_team
    click_on 'Create New'

    fill_in 'title',   with: team.name
    fill_in 'input_1', with: team.acces_code

    within(:css, 'md-dialog-actions') do
      click_on 'Create Team'
    end
  end

  private

    def unique(name)
      name + rand(10000000).to_s
    end
end
