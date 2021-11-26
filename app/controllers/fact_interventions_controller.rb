class FactInterventionsController < ApplicationController
  before_action :set_fact_intervention, only: %i[ show edit update destroy ]

  # GET /fact_interventions or /fact_interventions.json
  def index
    @fact_interventions = FactIntervention.all
  end

  # GET /fact_interventions/1 or /fact_interventions/1.json
  def show
  end

  # GET /fact_interventions/new
  def new
    @fact_intervention = FactIntervention.new
  end

  # GET /fact_interventions/1/edit
  def edit
  end

  # POST /fact_interventions or /fact_interventions.json
  def create
    @fact_intervention = FactIntervention.new(fact_intervention_params)

    respond_to do |format|
      if @fact_intervention.save
        format.html { redirect_to @fact_intervention, notice: "Fact intervention was successfully created." }
        format.json { render :show, status: :created, location: @fact_intervention }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fact_intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fact_interventions/1 or /fact_interventions/1.json
  def update
    respond_to do |format|
      if @fact_intervention.update(fact_intervention_params)
        format.html { redirect_to @fact_intervention, notice: "Fact intervention was successfully updated." }
        format.json { render :show, status: :ok, location: @fact_intervention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fact_intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fact_interventions/1 or /fact_interventions/1.json
  def destroy
    @fact_intervention.destroy
    respond_to do |format|
      format.html { redirect_to fact_interventions_url, notice: "Fact intervention was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fact_intervention
      @fact_intervention = FactIntervention.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fact_intervention_params
      params.require(:fact_intervention).permit(:employee_id, :building_id, :battery_id, :column_id, :elevator_id, :intervention_start_date_time, :intervention_end_date_time, :result, :report, :status_opt)
    end
end
