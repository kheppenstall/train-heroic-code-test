## Train Heroic Code Test

Thanks for taking a look at my response to the code test. Included here are some directions to running my test, responses to the questions you posed in the directions, and areas for improvement and questions. If you have any questions about my code or process send me an email at kyle.heppenstall@gmail.com.

### Getting Started

1. Make sure you have Ruby 2.3+ on your machine (`brew install ruby` if you use homebrew).
1. Make sure you have Google Chrome installed on your machine.
1. Install bundler: `gem install bundler` (checkout their site [here](https://bundler.io/)).
1. Clone the repo: `git clone https://github.com/kheppenstall/train-heroic-code-test.git`.
1. Move in the directory: `cd train-heroic-code-test`.
1. Install dependencies: `bundle install`.
1. Run the test script: `rspec`.

### Response to questions

#### Test Failures

The test fails at the nearest proceeding `expect` statement. For example, if an invalid name or non-unqique emails is entered then the test does not fail until the `expect(page).to have_content 'No Teams'` line. This is because the `Start your Free Trial` link can still be clicked it just does not move you on to the next page (and the current page does not have the text 'No Teams'). To ensure my names were unique I used the Faker gem with a `unique` helper method to append random numbers to fields that needed to be unique for the test.

The tests also fail occasionally due to some timing issues (see the top of the areas for improvement section).

#### Open source libs used and why

My first decision was to use Ruby with RSpec. I chose those two because I am most comfortable writing code in Ruby, and RSpec is my favorite Ruby testing library. Next I chose to use [Capybara](http://www.rubydoc.info/github/jnicklas/capybara) to harness Selenium. Capybara has descriptive, simple names like `click_on` and `have_css`. It also lets you select links within certain css selectors in case there are multiple links with the same name on a page. I also find that Capybara does well waiting for a page to load while searching for page elements. After reading this [blog post](https://www.varvet.com/blog/why-wait_until-was-removed-from-capybara) from the primary author of Capybara I was convinced on it.

Since I'd only written feature test for Rails applications, this [open source project](https://github.com/yovasx2/rspec-capybara-101) helped me with some of the setup in my `spec_helper.rb` file. Next I chose to use both byebug and pry to pause tests to look into what was happening. Byebug creates a useful history but pry was a bit less likely to make the test crash when I started writing expect statements in the terminal or searching around the `page` or `current_path`. I also used the [Faker](https://github.com/stympy/faker) library to create information for the coach and teams. Its useful dynamically creating realistic emails, usernames, and passwords so that the test is not always running with the same text. This helped me catch edge cases like the site disallowing apostrophes in names. Lastly, I chose to test on Chrome because it is the most [commonly used web browser](https://en.wikipedia.org/wiki/Usage_share_of_web_browsers).

### Areas for Improvement and Questions

One big area of improvement is that right now the test is not deterministic. The test passes most times but occasionally fails or times out. The main cause of these failures is the timing of the Selenium script against the loading of page. If an expect statement occurs before a page is loaded (even with a default max wait time of 10 seconds) then the test will fail. A stale element reference error also can occur when the script attempts to click an element with a reference that is no longer valid. I was getting this error more frequently and used this [stack overflow post](https://stackoverflow.com/questions/5709204/random-element-is-no-longer-attached-to-the-dom-staleelementreferenceexception) to help me reduce its frequency, although its not gone entirely.

Another area of improvement would be to test this functionality on more than just Chrome. After some brief research it looks like Sauce Labs could be an interesting technology to check out. How do you test for multiple browsers this in your feature tests?

To improve the test further I would like to get more validation that the teams are actually persisting to the database. One way to do this might be to call an internal API after the account and teams are created to make sure they persisted to the database. Is there an internal API at TrainHeroic that is used in feature tests?

I ran into some drawbacks with using Capybara with Angular. For example clicking links was difficult in Angular because there is occasionally not an `href` tag on the link (i.e. when clicking on 'Calendar'). Is there an angular specific technology that is commonly used for feature testing?

