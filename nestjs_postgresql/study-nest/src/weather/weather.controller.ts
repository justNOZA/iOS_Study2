import { Controller, Get, Res } from '@nestjs/common';

@Controller('weather')
export class WeatherController {

    @Get('nagoya')
    getWeather(@Res() res){
    // this.appService.getHello()
    res.status(200).send(__dirname);
  }
}
