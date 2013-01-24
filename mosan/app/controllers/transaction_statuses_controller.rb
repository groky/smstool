class TransactionStatusesController < ApplicationController
  # GET /transaction_statuses
  # GET /transaction_statuses.json
  def index
    @transaction_statuses = TransactionStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transaction_statuses }
    end
  end

  # GET /transaction_statuses/1
  # GET /transaction_statuses/1.json
  def show
    @transaction_status = TransactionStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction_status }
    end
  end

  # GET /transaction_statuses/new
  # GET /transaction_statuses/new.json
  def new
    @transaction_status = TransactionStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction_status }
    end
  end

  # GET /transaction_statuses/1/edit
  def edit
    @transaction_status = TransactionStatus.find(params[:id])
  end

  # POST /transaction_statuses
  # POST /transaction_statuses.json
  def create
    @transaction_status = TransactionStatus.new(params[:transaction_status])

    respond_to do |format|
      if @transaction_status.save
        format.html { redirect_to @transaction_status, notice: 'Transaction status was successfully created.' }
        format.json { render json: @transaction_status, status: :created, location: @transaction_status }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transaction_statuses/1
  # PUT /transaction_statuses/1.json
  def update
    @transaction_status = TransactionStatus.find(params[:id])

    respond_to do |format|
      if @transaction_status.update_attributes(params[:transaction_status])
        format.html { redirect_to @transaction_status, notice: 'Transaction status was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_statuses/1
  # DELETE /transaction_statuses/1.json
  def destroy
    @transaction_status = TransactionStatus.find(params[:id])
    @transaction_status.destroy

    respond_to do |format|
      format.html { redirect_to transaction_statuses_url }
      format.json { head :ok }
    end
  end
end
