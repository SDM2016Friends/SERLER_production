class ShareController < ApplicationController
    def share_results_email
        puts params.require(:search_id)
        puts params.require(:email)
        # @search = Search.find(search_id)
        
        if search_params[:id]
          @search = Search.find(search_params[:id])
        else
          @search = Search.new(search_params)
    
          if(@search.search_fields.blank?)
            if search_params[:search_fields_attributes]
              @search.search_fields.build(search_params[:search_fields_attributes][0])
            else
              @search.search_fields.build({op1: "", field: "", op2:"", content:""})
            end
          end
        end
    
        query_string = ""
        query_author = false
    
        @search.search_fields.each do |search_field|
          unless search_field.content.blank?
            query_string << "#{search_field.op1} " unless query_string.blank?
            query_string << "#{search_field.field} "
            query_string << "#{search_field.op2} "
    
            query_author = true if search_field.field == "name" or search_field.field == "name_abbr"
    
            if search_field.op2 == "=" || search_field.op2 == ">" || search_field.op2 == "<"
              query_string << "'#{search_field.content}' "
            else
              query_string << "'%#{search_field.content}%' "
            end
          end
        end
    
        unless @search.from_date.blank?
          query_string << "AND " unless query_string.blank?
          query_string << "published_time >= "
          query_string << "'#{@search.from_date}' "
        end
    
        unless @search.to_date.blank?
          query_string << "AND " unless query_string.blank?
          query_string << "published_time <= "
          query_string << "'#{@search.to_date}' "
        end
    
        scope_proc = search_scope(query_string, query_author)
        @results = scope_proc.call(EvidenceSource)
        if ShareMailer.share_results_email(@results, params.require(:email)).deliver!
          render json: {success: true}
        else
          render json: {success: false}, status: 400
        end
    end
    
      private
      def search_params
        if params.include?(:search)
          params.require(:search).permit(:id, :from_date, :to_date, :name, :saved_on,
                                         :search_fields_attributes => [:content,:field,:op1,:op2,:_destroy]);
        else
          params.permit(:search).permit(:id)
        end
      end
      
      def search_scope(query_string, query_author=false)
          -> (model) { model.where(query_string)}
      end
end
