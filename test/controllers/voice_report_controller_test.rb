require 'test_helper'

class VoiceReportControllerTest < ActionDispatch::IntegrationTest
  test "should get report" do
    get voice_report_report_url
    assert_response :success
  end

end
