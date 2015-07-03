module FormHelpers
  def render_text_field(f, field, opts = {}, &block)
    content_tag(:article, class: "form-group", id: "field_#{field}") do
      concat(f.label(field, opts[:label_text], class: "control-label col-sm-2"))
      concat(content_tag(:div, class: "col-sm-7") do
        if block
          concat(yield)
        else
          concat(f.text_field(field, class: "form-control"))
        end
      end)

      if f.object.errors[field].any?
        concat(content_tag(:p, class: "help-block col-sm-3") do
          concat(f.object.errors[field].first)
        end)
      end
    end
  end

  def render_submit(f, button_text)
    content_tag(:article, class: "form-group submit_button") do
      concat(content_tag(:div, class: "col-sm-offset-2 col-sm-10") do
        concat(f.submit button_text, class: "btn btn-primary")
      end)
    end
  end

  def errors_for(object)
    if object.errors.any?
      content_tag(:article, class: "form-group") do
        concat(content_tag(:div, class: "panel panel-danger") do
          concat(content_tag(:div, class: "panel-body") do
            concat "#{object.class} has errors"
          end)
        end)
      end
    end
  end
end