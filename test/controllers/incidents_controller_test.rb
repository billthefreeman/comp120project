require 'test_helper'

class IncidentsControllerTest < ActionController::TestCase
  setup do
    @incident = incidents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incidents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incident" do
    assert_difference('Incident.count') do
      post :create, incident: { cate_id: @incident.cate_id, closed_date_time: @incident.closed_date_time, incident_description: @incident.incident_description, location: @incident.location, other_cate_description: @incident.other_cate_description, processed_date_time: @incident.processed_date_time, report_date_time: @incident.report_date_time, reporter_id: @incident.reporter_id, severity: @incident.severity, solved_date_time: @incident.solved_date_time, status_id: @incident.status_id }
    end

    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should show incident" do
    get :show, id: @incident
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incident
    assert_response :success
  end

  test "should update incident" do
    patch :update, id: @incident, incident: { cate_id: @incident.cate_id, closed_date_time: @incident.closed_date_time, incident_description: @incident.incident_description, location: @incident.location, other_cate_description: @incident.other_cate_description, processed_date_time: @incident.processed_date_time, report_date_time: @incident.report_date_time, reporter_id: @incident.reporter_id, severity: @incident.severity, solved_date_time: @incident.solved_date_time, status_id: @incident.status_id }
    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should destroy incident" do
    assert_difference('Incident.count', -1) do
      delete :destroy, id: @incident
    end

    assert_redirected_to incidents_path
  end
end
