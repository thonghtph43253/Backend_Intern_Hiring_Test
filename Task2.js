require('dotenv').config();
const axios = require('axios');


const API_URL = process.env.OPENWEATHERMAP_API_KEY;
const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";

async function getWeatherData(city){
    try{
        const response = await axios.get(`${BASE_URL}?q=${city}&appid=${API_URL}&units=metric`);
        
        const data = response.data;
        return{
            city: data.name,
            temperature: data.main.temp,
            humidity: data.main.humidity,
            desription: data.weather[0].description,
            timestamp: new Date().toString()
        }
    }catch(error){
        console.error(error);
    }
}

getWeatherData("Hanoi").then(console.log);

module.exports = getWeatherData;