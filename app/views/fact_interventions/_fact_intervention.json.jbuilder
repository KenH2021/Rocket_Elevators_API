json.extract! fact_intervention, :id, :employee_id, :building_id, :battery_id, :column_id, :elevator_id, :intervention_start_date_time, :intervention_end_date_time, :result, :report, :status_opt, :created_at, :updated_at
json.url fact_intervention_url(fact_intervention, format: :json)
