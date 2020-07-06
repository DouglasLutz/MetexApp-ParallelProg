defmodule Metex do

  # cities = [
  #   "Paris, France",
  #   "Doha, Qatar",
  #   "Amsterdam, Netherlands",
  #   "Venice, Italy",
  #   "Kyoto, Japan",
  #   "Barcelona, Spain",
  #   "Athens, Greece",
  #   "Sydney, Australia",
  #   "San Miguel de Allende, Mexico",
  #   "Havana, Cuba",
  #   "Beirut, Lebanon",
  #   "Cape Town, South Africa",
  #   "Budapest, Hungary",
  #   "Buenos Aires, Argentina",
  #   "Lisbon, Portugal",
  #   "Luang Prabang, Laos",
  #   "Florence, Italy",
  #   "Istanbul, Turkey",
  #   "Hong Kong, China",
  #   "Copenhagen, Denmark",
  #   "Jerusalem, Israel",
  #   "Krakow, Poland",
  #   "Bruges, Belgium",
  #   "Busan, South Korea",
  #   "Dubrovnik, Croatia",
  #   "Cartagena, Colombia",
  #   "Edinburgh, Scotland",
  #   "Québec City, Canada",
  #   "Hamburg, Germany",
  #   "Jaipur, India",
  #   "Queenstown, New Zealand",
  #   "Rio de Janeiro, Brazil",
  #   "São Paulo, Brazil",
  #   "Porto Alegre, Brazil",
  #   "Santa Maria, Rio Grande do Sul, Brazil",
  #   "Caxias do Sul, Rio Grande do Sul, Brazil",
  #   "Passo Fundo, Rio Grande do Sul, Brazil",
  #   "Alegrete, Rio Grande do Sul, Brazil",
  #   "Pelotas, Rio Grande do Sul, Brazil"
  # ]

  def sequential_temperatures_of(cities) do
    cities |> Enum.map(fn city ->
      Metex.Worker.temperature_of(city)
    end)
  end

  def paralel_temperatures_of(cities) do
    coordinator_pid = spawn(Metex.Coordinator, :loop, [[], Enum.count(cities)])

    cities |> Enum.each(fn city ->
      worker_pid = spawn(Metex.Worker, :loop, [])
      send worker_pid, {coordinator_pid, city}
    end)
  end
end
