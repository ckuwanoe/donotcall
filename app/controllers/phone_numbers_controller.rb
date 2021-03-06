class PhoneNumbersController < ApplicationController
  # GET /phone_numbers
  # GET /phone_numbers.json
  def index
    @phone_numbers = PhoneNumber.all
  end

  # GET /phone_numbers/1
  # GET /phone_numbers/1.json
  def show
  end

  # GET /phone_numbers/new
  def new
    @phone_number = PhoneNumber.new
  end

  # GET /phone_numbers/1/edit
  def edit
  end

  # POST /phone_numbers
  # POST /phone_numbers.json
  def create
#    @phone_number = PhoneNumber.new(phone_number_params)
#    respond_to do |format|
#      if @phone_number.save
#        format.html { redirect_to @phone_number, notice: 'Phone number was successfully created.' }
#        format.json { render action: 'show', status: :created, location: @phone_number }
#      else
#        format.html { render action: 'new' }
#        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
#      end
#    end
    file_store = DocumentUploader.new
    file_store.store!(params[:file])
    success = PhoneNumber.delay.import_csv(file_store.current_path, params[:header], params[:column_number])

    respond_to do |format|
      if success
        format.html { redirect_to new_phone_number_path, notice: 'Phone numbers were successfully added. Background process running.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone_numbers/1
  # PATCH/PUT /phone_numbers/1.json
  def update
    respond_to do |format|
      if @phone_number.update(phone_number_params)
        format.html { redirect_to @phone_number, notice: 'Phone number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_numbers/1
  # DELETE /phone_numbers/1.json
  def destroy
    @phone_number.destroy
    respond_to do |format|
      format.html { redirect_to phone_numbers_url }
      format.json { head :no_content }
    end
  end
end
