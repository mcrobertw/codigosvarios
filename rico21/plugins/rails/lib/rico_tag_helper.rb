module RicoTagHelper

  def javascript_on_load(js)
    javascript_tag "Event.observe(window, 'load', function(){ #{js} })"
  end

  def accordion(titles, headers, options={})
    javascript_on_load "new Rico.Accordion('#{titles}', '#{headers}', #{options_for_javascript(options)})"
  end
  
  def round_corner(element, options={})
    javascript_tag "Rico.Corner.round('#{element}', #{options_for_javascript(options)})"
  end
  
  def javascript_load_tag(*modules)
    javascript_tag modules.map{|script| "Rico.loadModule('#{script}.js');"}.join(" ")
  end
end