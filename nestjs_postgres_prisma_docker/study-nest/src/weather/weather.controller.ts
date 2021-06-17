import { Controller, Get, Res } from '@nestjs/common';
import { AppService} from 'src/app.service';

var wjsonData = require("../../json/weather.json");
@Controller('weather')
export class WeatherController {

  constructor(
    private readonly appService: AppService
  ){}

    @Get('nagoya')
    getWeather(@Res() res){
    // this.appService.getHello()
    res.status(200).send(wjsonData);
  }
}
