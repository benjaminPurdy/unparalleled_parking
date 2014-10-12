class BranchesController < ApplicationController
  before_action :set_branch, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  # GET /branches.json
  def index
#    @branch1 = Branch.new(uid: 'root1', parent: '', range: 'some range')
#    @branch2 = Branch.new(uid: 'root2', parent: '', range: 'some range')
#    @branch3 = Branch.new(uid: 'root3', parent: '', range: 'some range')
#    @branch4 = Branch.new(uid: 'child_of_root1', parent: 'root1', range: 'some range')
#    @branch5 = Branch.new(uid: 'child_of_root1', parent: 'root1', range: 'some range')
#    @branch6 = Branch.new(uid: 'child_of_root2', parent: 'root2', range: 'some range')
#    @branch1.save
#    @branch2.save
#    @branch3.save
#    @branch4.save
#    @branch5.save
#    @branch6.save
    @branches = Branch.where(parent: '')
    @branch = Branch.new
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
  end

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
  end

# GET /branches/parent/1
  def children
    @parentTitle = Branch.find(params[:id]).uid
    @branches = Branch.where(parent: @parentTitle)
    render :json => @branches.to_json
  end
  # POST /branches
  # POST /branches.json
  def create
    @branch = Branch.new(branch_params)
    @starting_range = params[:branch][:text]
    @ending_range = params[:branch][:range]
    @starting_range = Integer(@starting_range)
    @ending_range = Integer(@ending_range)
    if @starting_range <= @ending_range
      @random_number = Random.new.rand(@starting_range..@ending_range)
      @branch.text = @random_number.to_s
      @branch.range = @starting_range.to_s + " - " + @ending_range.to_s
      @branch.uid = params[:branch][:uid].strip
      @branch.parent = params[:branch][:parent].strip
        respond_to do |format|
          if @branch.save
            format.html { redirect_to action: "index", notice: 'Branch was successfully updated.' }
            format.json { render action: 'show', status: :created, location: @branch }
          else
            format.html { render action: 'new' }
            format.json { render json: @branch.errors, status: :unprocessable_entity }
          end
        end
     else
          format.json { render json: "[{error: invalid range}]", status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to @branch, notice: 'Branch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    @branch = Branch.find(params[:id])
    @parentTitle = Branch.find(params[:id]).uid
    Branch.where(parent: @parentTitle).delete_all
    @branch.destroy
    render :json => @branch.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def branch_params
      params.permit(:uid, :parent, :text, :range, :id, :branch)
    end
end
