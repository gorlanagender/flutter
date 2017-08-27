module ApplicationHelper
  def build_form_errors(act_rec, html_section_id, opt = {id_prefix: nil, symbol_map: nil, id_map: {}, associations: []})
    act_rec = act_rec.data_object if act_rec.is_a? WbCommon::Presenters::ScalarPresenter
    arr = [html_section_id]
    elem_id_prefix = opt[:id_prefix]||(act_rec.class.model_name.singular + '_')
    field_errors = []
    alt_mesg_method = act_rec.respond_to?('full_messages_for')

    if opt[:associations].blank?
      msgs = act_rec.errors.messages
    else
      msgs = act_rec.errors.messages.reject {|k,v| k.to_s.index('.')}
    end
    msgs.each do |fld, messages|
      elem_id = (opt[:id_map] && opt[:id_map][fld]) ? opt[:id_map][fld] : elem_id_prefix + fld.to_s
      if opt[:hide_field_name]
        messages.each do |message|
          # If we are hiding the field names then if different fields have the same error message we want to prevent showing duplicates
          field_errors << [elem_id, message] if opt[:no_duplicate] || (field_errors.flatten.exclude? message)
        end
      else
        (alt_mesg_method ? act_rec.full_messages_for(fld, opt[:symbol_map]) : act_rec.errors.full_messages_for(fld)).each do |msg|
          field_errors << [elem_id, msg]
        end
      end
    end

    if opt[:associations].present?
      assoc_arr = opt[:associations].is_a?(Array) ? opt[:associations] : [opt[:associations]]
      assoc_arr.each do |assoc|
        #   Case 1: assoc = @bond.terms ==> an activerecord relation
        #   Case 2: assoc = [@bond.one_term] ==> a single Term record using "f.fields_for :terms"
        #   Case 3: assoc = [@bond.reg_term, "terms"] ==> a single TermRegular record using "f.fields_for :terms"
        #           Case 3 is to handle single record (index 0) using specified class name for html element id.
        #   Case 3b: assoc = [[@bond.reg_term, @bond.mnt_term], "terms"] ==> two Terms records
        #           Case 3b is to handle multiple records, starting with index 0, using specified class name for html element ids.
        if !assoc.is_a?(Array) # Case 1
          kls = assoc.klass.model_name.plural
        elsif assoc.size == 1 # Case 2
          kls = assoc[0].class.model_name.plural
        else # Case 3
          kls = assoc[1]
          assoc.delete_at(1)
          if assoc[0].is_a?(Array) # Case 3b
            assoc = assoc[0]
          end
        end
        alt_mesg_method = assoc[0].respond_to?('full_messages_for')
        assoc.each_with_index do |row, ndx|
          ndx = apply_padding(assoc, opt[:id_pad], ndx) if opt[:id_pad].present?
          if row.errors.any?
            row.errors.messages.each do |fld, messages|
              # TODO: symbol mapping for nested attributes not yet implemented (low priority; may not need)
              (alt_mesg_method ? row.full_messages_for(fld) : row.errors.full_messages_for(fld)).each do |msg|
                if fld.to_s.include? '.'
                  x = fld.to_s.split('.', 2)
                  fld = "#{x[0]}_attributes_#{x[1]}"
                end
                elem_id = (opt[:id_map] && opt[:id_map][fld]) ? opt[:id_map][fld] :
                              act_rec.class.model_name.singular + '_' + kls + '_attributes_' + ndx.to_s + '_' + fld.to_s
                field_errors << [elem_id, msg]
              end
            end
          end
        end
      end
    end

    arr << field_errors.uniq
    arr.to_json.html_safe
  end

end
