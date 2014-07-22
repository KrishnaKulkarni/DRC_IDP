class LocationsController < ApplicationController

  def groups
    if params[:id].to_i == 0
      @locations = {
        'villages'  => Village.all,
      }
    else
      group = Group.find(params[:id])

      @locations = {
        'villages'  => group.villages,
      }
    end
    render :locations, layouts: false
  end

  def collectives
    if params[:id].to_i == 0
      @locations = {
        'villages'  => Village.all,
        'groups'  => Group.all
      }
    else
      collective = Collective.find(params[:id])

      @locations = {
        'villages'  => collective.villages,
        'groups'  => collective.groups
      }
    end
    render :locations, layouts: false
  end

  def territories
    if params[:id].to_i == 0
      @locations = {
        'villages'  => Village.all,
        'groups'  => Group.all,
        'collectives'  => Collective.all
      }
    else
      territory = Territory.find(params[:id])

      @locations = {
        'villages'  => territory.villages,
        'groups'  => territory.groups,
        'collectives'  => territory.collectives
      }
    end
    render :locations, layouts: false
  end

  def provinces
    if params[:id].to_i == 0
      @locations = {
        'villages'  => Village.all,
        'groups'  => Group.all,
        'collectives'  => Collective.all,
        'territories'  => Territory.all
      }
    else
      province = Province.find(params[:id])

      @locations = {
        'villages'  => province.villages,
        'groups'  => province.groups,
        'collectives'  => province.collectives,
        'territories'  => province.territories
      }
    end
    render :locations, layouts: false
  end

end