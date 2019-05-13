# <div class="input-group apply-colorpicker">
#   <input type="text" class="form-control input-lg" value="#FFF"/>
#   <span class="input-group-append">
#     <span class="input-group-text colorpicker-input-addon"><i></i></span>
#   </span>
# </div>
class ColorPickerInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    template.content_tag(:div, class: 'input-group colorpicker-component apply-colorpicker') do
      template.concat @builder.input_field(attribute_name, class: 'form-control')
      template.concat span_tag
    end
  end

  def span_tag
    template.content_tag(:span, class: 'input-group-append') do
      template.concat span_color_tag
    end
  end

  def span_color_tag
    template.content_tag(:span, class: 'input-group-text colorpicker-input-addon') do
      template.concat template.content_tag(:i)
    end
  end
end
