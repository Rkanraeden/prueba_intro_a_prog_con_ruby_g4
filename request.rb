require "uri"
require "net/http"
require "json"

# Url de nasa y api_key generada desde nasa.
#url: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key="
#api_key: "1AJo1o4NOLOvgN3qePKHVhZhwjTcMZBz29vhl6ej"



# Crear el método request que reciba una url y api_key y devuelva el hash con los resultados. 

def request(url)
    
    url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=1AJo1o4NOLOvgN3qePKHVhZhwjTcMZBz29vhl6ej")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    results = JSON.parse(response.read_body)
end

data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=1AJo1o4NOLOvgN3qePKHVhZhwjTcMZBz29vhl6ej")


# se itera tomando los 10 primeros elementos para seleccionar información
# images = data["photos"][0..9].map do |image|
#     image["img_src"]
# end

# se valida con puts para ver si genera data
#puts data
#Creé metodo de prueba para ver si trae la data

# def prueba (data)
#     images = data["photos"][0..9].map do |image|
#         image["img_src"]
#     end
# end
# puts data
def build_web_page(data)
    # Se toma el código de la iteración
    images = data["photos"][0..9].map do |image|
        image["img_src"]
    end
    # Se crea la estructura html y se llama a las fotos en la lista ordenada
    html = "
    <html>
    <head>
    </head>
    <body>
        <ul>
        "
        images.each do |image|
            html += "<img src='#{image}'></li>\n"
        end

        html += "
        </ul>
    </body>
    </html>
    "
    File.write('index.html', html)
end

build_web_page (data)
