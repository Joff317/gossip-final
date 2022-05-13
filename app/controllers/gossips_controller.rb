class GossipsController < ApplicationController
   before_action :authorize, only: [:new, :edit, :destroy]

   def index 
   @gossips = Gossip.all.reorder(id: :asc, title: :asc, content: :asc)

   puts "$" * 60
   puts "Voici le nombre de potins dans la base : #{@gossips.length}"
   puts "$" * 60
   end

   def show 
      @gossip = Gossip.find(params[:id])
      @comments = Comment.where('gossip_id': @gossip.id)
   end
   
  def new
   @new_gossip = Gossip.new 
  end

  def edit 
   @gossip = Gossip.find(params[:id])
  end

  def create 
   @gossip = Gossip.new("title" => params[:title],
                        "content" => params[:content],
                         user: current_user)
                        

   if @gossip.save 
      flash[:success] = "Le potin à bien été crée" #Specifying a message when it succeeds
      redirect_to gossips_path
   else
      render 'new'
   end
  end


 def update
   @gossip = Gossip.find(params[:id]) 
   gossip_params = params.require(:gossip).permit(:title, :content)
   if @gossip.update(gossip_params)
   redirect_to action: "show", notice: 'Success', :id => @gossip.id
   else 
   render :action => 'edit'
   end   
  end

  def destroy
   @gossip = Gossip.find(params[:id])
      @gossip.destroy
      redirect_to gossips_path
  end

end