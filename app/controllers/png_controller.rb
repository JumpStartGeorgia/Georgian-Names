# encoding: utf-8
class PngController < ApplicationController

  def rank
    if !params[:rank].blank?
      respond_to do |format|
        format.png {  
          size = 12
          case params[:rank].length
            when 1
              size = 24
            when 2
              size = 21
            when 3
              size = 18
            when 4
              size = 15
          end

          file_path = "#{Rails.root}/tmp/rank_#{params[:rank]}_#{Time.now.strftime("%Y%m%dT%H%M%S%z")}.png"

          x = Subexec.run "convert \"#{Rails.root}/app/assets/images/gold-medal-th.png\" \\
                      -size 68x \\
                      -background transparent \\
                      -fill black \\
                      -pointsize #{size} \\
                      -gravity center \\
                      caption:\"##{view_context.number_with_delimiter(params[:rank])} \" \\
                      -gravity center \\
                      -geometry +0-14 \\
                      -composite \"#{file_path}\""

          send_file "#{file_path}", :type => "image/png", :disposition => 'inline', :filename => "rank_#{params[:rank]}"

          File.delete("#{file_path}")
        }
      end
    end
  end

end