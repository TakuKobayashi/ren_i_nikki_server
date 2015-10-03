# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def bench(title = "")
  benchmark_start = Time.now
  puts "== Seeding #{title} Data ".ljust(79, "=")
  context = yield
  elapsed = (Time.now - benchmark_start).to_d.floor(4).to_s
  puts " -> #{elapsed}s"
  context
end

def import_sheet(sheet, base_class, options = {})
  base_class.connection.execute("TRUNCATE TABLE #{base_class.table_name}")
  datas = []
  headers = sheet.row(1)
  rindex = 1
  sheet.each do |row| # Arrayのeachではない。
    if rindex > 1
      datas << headers.each_with_index.each_with_object({}) do |(col, cindex), o|
        if col.blank?
          # do nothing
        else
          o[col] = sheet.cell(rindex, cindex + 1)
        end
      end
    end
    break if options[:limit] && (rindex + 1) == options[:limit]
    rindex += 1
  end
  mod_datas = datas.compact.map do |data|
    data = data.with_indifferent_access
    data = yield(data) if block_given?
    case true
    when data.is_a?(Hash) then base_class.new(data)
    when data.is_a?(Array) then data.map {|d| base_class.new(d)}
    end
  end.compact.flatten

  base_class.import(mod_datas)
end

bench("mst_api_config") do
  book = ::Roo::Excelx.new("db/mst_data/mst_api_config.xlsx")
  import_sheet(book.sheet("mst_api_configs"), Mst::ApiConfig)
  oauth_api_config = YAML.load(File.read("#{Rails.root}/config/api_config.yml"))
  oauth_api_config.each do |api_name, keys|
    config = Mst::ApiConfig.new(type: "Mst::" + api_name.classify + "Api")
    config.attributes = keys
    config.save!
  end
  import_sheet(book.sheet("mst_api_feature_configs"), Mst::ApiFeatureConfig)
end


bench("mst_town_quest") do
  book = ::Roo::Excelx.new("db/mst_data/mst_town_quest.xlsx")
  import_sheet(book.sheet("mst_town_quest"), Mst::TownQuest)
end

bench("minagoraswitch_master_data") do
  book = ::Roo::Excelx.new("db/mst_data/minagoraswitch_master_data.xlsx")
  import_sheet(book.sheet("mst_stage_gimmick"), Mst::StageGimmick)
  import_sheet(book.sheet("mst_stage"), Mst::Stage)
  import_sheet(book.sheet("mst_gimmick"), Mst::Gimmick)
end

bench("cyber_growth_master_data") do
  book = ::Roo::Excelx.new("db/mst_data/cyber_growth_master_data.xlsx")
  import_sheet(book.sheet("mst_sectors"), Mst::Sector)
  import_sheet(book.sheet("mst_sector_quizzes"), Mst::SectorQuiz)
  import_sheet(book.sheet("mst_sector_quiz_choices"), Mst::SectorQuizChoice)
end

bench("cyber_growth_enemy") do
  book = ::Roo::Excelx.new("db/mst_data/cyber_growth_enemy.xlsx")
  import_sheet(book.sheet("mst_cyber_growth_enemies"), Mst::CyberGrowthEnemy)
end

bench("mst_sick") do
  book = ::Roo::Excelx.new("db/mst_data/mst_sick.xlsx")
  import_sheet(book.sheet("mst_sick"), Mst::Sick)
endAdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')