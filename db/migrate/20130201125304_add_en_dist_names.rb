class AddEnDistNames < ActiveRecord::Migration
  def up
    districts = [["1","Mtatsminda"], ["2","Vake"], ["3","Saburtalo"], ["4","Krtsanisi"], ["5","Isani"], ["6","Samgori"], ["7","Chugureti"], ["8","Didube"], ["9","Nadzaladevi"], ["10","Gldani"], ["11","Sagarejo"], ["12","Gurjaani"], ["13","Signagi"], ["14","Dedoplistskaro"], ["15","Lagodekhi"], ["16","Kvareli"], ["17","Telavi"], ["18","Akhmeta"], ["19","Tianeti"], ["20","Rustavi"], ["21","Gardabani"], ["22","Marneuli"], ["23","Bolnisi"], ["24","Dmanisi"], ["25","Tsalka"], ["26","Tetritskaro"], ["27","Mtskheta"], ["28","Dusheti"], ["29","Kazbegi"], ["30","Kaspi"], ["31","Akhalgori"], ["32","Gori"], ["33","Kareli"], ["35","Khashuri"], ["36","Borjomi"], ["37","Akhaltsikhe"], ["38","Adigeni"], ["39","Aspindza"], ["40","Akhalkalaki"], ["41","Ninotsminda"], ["43","Oni"], ["44","Ambrolauri"], ["45","Tsageri"], ["46","Lentekhi"], ["47","Mestia"], ["48","Kharagauli"], ["49","Terjola"], ["50","Sachkhere"], ["51","Zestaponi"], ["52","Bagdati"], ["53","Vani"], ["54","Samtredia"], ["55","Khoni"], ["56","Chiatura"], ["57","Tkibuli"], ["58","Tskaltubo"], ["59","Kutaisi"], ["60","Ozurgeti"], ["61","Lanchkhuti"], ["62","Chokhatauri"], ["63","Abasha"], ["64","Senaki"], ["65","Martvili"], ["66","Khobi"], ["67","Zugdidi"], ["68","Tsalenjikha"], ["69","Chkhorotsku"], ["70","Poti"], ["79","Batumi"], ["80","Keda"], ["81","Kobuleti"], ["82","Shuakhevi"], ["83","Khelvachauri"], ["84","Khulo"], ["85","Liakhvi"], ["999","Tbilisi"]]
    
    DistrictName.all.each do |district|
      index = districts.index{|x| x[0] == district.id.to_s}
      if index
        district.name_en = districts[index][1]
        district.save
      end
    end
  end

  def down
    # do nothing
  end
end
