import { Controller, Get, Res } from '@nestjs/common';


var wjsonData = require("../../json/weather.json");
@Controller('weather')
export class WeatherController {

    @Get('nagoya')
    getWeather(@Res() res){
    // this.appService.getHello()
    res.status(200).send(wjsonData);
  }
}
