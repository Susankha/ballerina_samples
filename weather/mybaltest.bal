import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.lang.jsons;

@http:config { basePath: "/test"}
service<http> Service1 {

    @http:GET {}
    @http:Path { value: "/res"}
    resource Resource1 (message m) {
        http:ClientConnector weatherService = create http:ClientConnector("http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=7edd664a7aa78ed241b4399e8d0c84d7");
        message backendServiceReq = {};
        message weatherReport = http:ClientConnector.get(weatherService, "", backendServiceReq);
        json jsonRes = messages:getJsonPayload(weatherReport);
        string city = jsons:getString(jsonRes,"$.name");
        float lon = jsons:getFloat(jsonRes, "$.coord.lon");
        float lat = jsons:getFloat(jsonRes, "$.coord.lat");
        float temp = jsons:getFloat(jsonRes, "$.main.temp");
        int pressure = jsons:getInt(jsonRes, "$.main.pressure");
        int humidity = jsons:getInt(jsonRes, "$.main.humidity");
        float temp_min = jsons:getFloat(jsonRes, "$.main.temp_min");
        float temp_max = jsons:getFloat(jsonRes, "$.main.temp_max");
        string desc = jsons:getString(jsonRes,"$.weather[0].description");
        json cityTmp = {"City":"","coord":{"lon":"","lat":""},"Weather":{"temp":"","pressure":"","humidity":"","temp_min":"","temp_max":"","description":""}};
        cityTmp.City=city;
        cityTmp.coord.lon=lon;
        cityTmp.coord.lat=lat;
        cityTmp.Weather.temp=temp;
        cityTmp.Weather.pressure=pressure;
        cityTmp.Weather.humidity=humidity;
        cityTmp.Weather.temp_min=temp_min;
        cityTmp.Weather.temp_max=temp_max;
        cityTmp.Weather.description=desc;
        messages:setJsonPayload(backendServiceReq,cityTmp);
        reply backendServiceReq;
        }
    
    }