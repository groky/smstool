class TransactionTypesController < ApplicationController
  # GET /transaction_types
  # GET /transaction_types.json
  def index
    @transaction_types = TransactionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transaction_types }
    end
  end

  # GET /transaction_types/1
  # GET /transaction_types/1.json
  def show
    @transaction_type = TransactionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction_type }
    end
  end

  # GET /transaction_types/new
  # GET /transaction_types/new.json
  def new
    @transaction_type = TransactionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction_type }
    end
  end

  # GET /transaction_types/1/edit
  def edit
    @transaction_type = TransactionType.find(params[:id])
  end

  # POST /transaction_types
  # POST /transaction_types.json
  def create
    @transaction_type = TransactionType.new(params[:transaction_type])

    respond_to do |format|
      if @transaction_type.save
        format.html { redirect_to @transaction_type, notice: 'Transaction type was successfully created.' }
        format.json { render json: @transaction_type, status: :created, location: @transaction_type }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transaction_types/1
  # PUT /transaction_types/1.json
  def update
    @transaction_type = TransactionType.find(params[:id])

    respond_to do |format|
      if @transaction_type.update_attributes(params[:transaction_type])
        format.html { redirect_to @transaction_type, notice: 'Transaction type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_types/1
  # DELETE /transaction_types/1.json
  def destroy
    @transaction_type = TransactionType.find(params[:id])
    @transaction_type.destroy

    respond_to do |format|
      format.html { redirect_to transaction_types_url }
      format.json { head :ok }
    end
  end
end
