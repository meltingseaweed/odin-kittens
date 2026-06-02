class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    turn_into_api(@kitten)
  end

  def show
    find_kitten
    turn_into_api(@kitten)
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:notice] = "New family member Meow!"
      redirect_to root_path
    else
      flash[:alert] = "Meow.. Some kind of error occurred.. but I'm a cat so I don't know what it was.."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    find_kitten
  end
  def update
    if @kitten.update!(kitten_params)
      flash[:notice] = "Kitten updated Meow!"
      redirect_to @kitten
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    find_kitten
    @kitten.destroy
    redirect_to root_path, notice: "Kitten found a happy new home, Meow!"
  end

  private

  def find_kitten
    @kitten = Kitten.find(params[:id])
  end

  def kitten_params
    params.expect(kitten: [ :name, :age, :cuteness, :softness ])
  end

  def turn_into_api(cat)
    respond_to do |format|
      format.html
      format.xml { render xml: cat }
      format.json { render json: cat }
    end
  end
end
