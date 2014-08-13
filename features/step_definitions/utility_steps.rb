Then(/^show me the app$/) do
  binding.pry
end

Then(/^show me the page$/) do
  save_and_open_page
end

Then(/^save the page$/) do
  save_page
end

Then(/^render the page$/) do
  save_and_open_screenshot
end

When(/^I wait until "(.*?)" is visible$/) do |selector|
  page.has_css?("#{selector}", visible: true)
end

Given(/^I wait for the ajax request to finish$/) do
  start_time = Time.now
  result = false
  while result == false do
    result = page.evaluate_script('jQuery.active === 0')
    if start_time + 5.seconds >= Time.now
      result = true
    else
      sleep 0.5
    end
  end
  sleep 0.5
end

When(/^I wait for (\d+) seconds$/) do |second_string|
  sleep(second_string.to_i)
end

# When(/^I travel (\d+) (months|days) into the future$/) do |time_amount, time_unit|
#   Timecop.travel time_amount.to_i.send(time_unit)
# end
