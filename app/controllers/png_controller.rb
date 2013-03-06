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

          x = Subexec.run "convert \"#{Rails.root}/app/assets/images/ribbon.png\" \\
                      -size 54x \\
                      -background transparent \\
                      -fill \"#FFECBD\" \\
                      -pointsize #{size} \\
                      -gravity center \\
                      caption:\"##{view_context.number_with_delimiter(params[:rank])} \" \\
                      -gravity center \\
                      -geometry +3-10 \\
                      -composite \"#{file_path}\""

          send_file "#{file_path}", :type => "image/png", :disposition => 'inline', :filename => "rank_#{params[:rank]}"

          File.delete("#{file_path}")
        }
      end
    end
  end

  def share_rank
    if !params[:rank].blank?
      respond_to do |format|
        format.png {  
          size = 23
          case params[:rank].length
            when 1
              size = 42
            when 2
              size = 39
            when 3
              size = 36
            when 4
              size = 29
          end

          if I18n.locale == :ka
            img = 'share_rank_geo.png'
          else
            img = 'share_rank_eng.png'
          end

          file_path = "#{Rails.root}/tmp/share_rank_#{params[:rank]}_#{Time.now.strftime("%Y%m%dT%H%M%S%z")}.png"

          x = Subexec.run "convert \"#{Rails.root}/app/assets/images/#{img}\" \\
                      -size 200x \\
                      -background transparent \\
                      -fill \"#FFECBD\" \\
                      -pointsize #{size} \\
                      -gravity center \\
                      caption:\"##{view_context.number_with_delimiter(params[:rank])} \" \\
                      -gravity center \\
                      -geometry +6+25 \\
                      -composite \"#{file_path}\""

          send_file "#{file_path}", :type => "image/png", :disposition => 'inline', :filename => "share_rank_#{params[:rank]}"

          File.delete("#{file_path}")
        }
      end
    end
  end

end
