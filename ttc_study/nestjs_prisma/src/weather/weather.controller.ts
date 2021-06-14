import { Controller, Get, Res } from '@nestjs/common';
import { PrismaClient } from '.prisma/client';

var wjsonData = require("../../json/weather.json");
const prisma = new PrismaClient();

@Controller('weather')
export class WeatherController {

    @Get('nagoya')
    getWeather(@Res() res){
    // this.appService.getHello()
    res.status(200).send(wjsonData);
  }
}
