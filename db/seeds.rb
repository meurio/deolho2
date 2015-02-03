# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  "Indústria, comércio e emprego",
  "Ciência e tecnologia",
  "Direitos humanos",
  "Educação",
  "Orçamento e fiscalização financeira",
  "Saúde e drogas",
  "Crianças e adolescentes",
  "Pessoas de terceira idade",
  "Meio ambiente e direitos dos animais",
  "Defesa do consumidor",
  "Obras públicas e infraestrutura",
  "Transportes e trânsito",
  "Turismo",
  "Eleições",
  "Megaeventos",
  "Transparência e participação",
  "Esportes e lazer",
  "Cultura"].each do |name|
    Category.create name: name
end
