
module RicoLiveGrid
  
  def find_livegrid_content_for(model, fields)
    order_by = params.select{|k,v| ((/s[0..9]*/ =~ k) == 0)}.map{|k,v| "#{fields[k[1..-1].to_i]} #{v}"}.join ',' 
    order_by = "#{fields[0]}" if order_by.nil? or order_by.empty?

    model.find( :all, 
                :order  => order_by,
                :limit  => params[:page_size],
                :conditions => livegrid_conditions(fields),
                :offset => params[:offset])    
  end  

  def livegrid_count_for(model, fields)
    model.count :conditions => livegrid_conditions(fields)
  end

  def livegrid_conditions(fields)
    params[:f].map{|k,v| "#{fields[k.to_i]} #{v[:op]} '%#{v['0'][0..-2]}%'"}.join ' AND ' if params[:f]
  end
end
