  class GroupsController < ApplicationController
  def index
  end

  def create
    @group = Group.new
    @group.users << current_user
    @group.save

    redirect_to edit_user_group_path(@user.id, @group.id)

    # new_user_group_squaring_event_path(@user.id, @group.id)
  end

  def edit
    @user = User.find(params[:user_id])
    @square = SquaringEvent.new
    @group = Group.find(params[:id])


    # Transaction.where("debtor_id = ? OR creditor_id = ?", current_user.id, current_user.id).reverse_order
  end

  def update
    @newUser = User.find_by(email: params[:email])
    if @newUser
      @group = Group.find(params["id"])
      oldTransactions = @group.transactions
      @group.users << @newUser
      @group.save
      allTransactions = @group.transactions
      @group_transactions = allTransactions - oldTransactions
      msg = {user: @newUser,group: @group_transactions}
    else
      msg = "We're Sorry, invalid e-mail"
    end
    respond_to do |format|
      format.js   { render :json => msg }
      format.json  { render :json => msg }
    end
  end

end
