# <div class="input-group">
#   <input type="text" class="form-control input-lg"/>
#   <span class="input-group-append">
#     <span class="input-group-text"><i></i></span>
#   </span>
# </div>
class GroupInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    input_classes = options[:input_html] ? options[:input_html][:class] : ''
    input_classes += ' form-control'

    template.content_tag(:div, class: 'input-group') do
      template.concat @builder.input_field(attribute_name, class: input_classes)
      template.concat span_tag
    end
  end

  def span_tag
    template.content_tag(:span, class: 'input-group-append') do
      template.concat span_group
    end
  end

  def span_group
    icon = options[:group_icon]
    icon = icon ? template.content_tag(:i, class: icon) {} : nil

    text = options[:group_text] || nil
    template.content_tag(:span, class: 'input-group-text') do
      template.concat icon || text
    end
  end
end
