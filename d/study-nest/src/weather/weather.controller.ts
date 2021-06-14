import { Controller, Get, Res } from '@nestjs/common';
import { AppService, PrismaService } from 'src/app.service';

var wjsonData = require("../../json/weather.json");
@Controller('weather')
export class WeatherController {

  constructor(
    private readonly appService: AppService,
    private readonly prisma: PrismaService
  ){}

    @Get('nagoya')
    getWeather(@Res() res){
    // this.appService.getHello()
    res.status(200).send(wjsonData);
  }
  @Get('nagoya2')
  async getDBWeather(@Res() res){
      res.status(200);
      res.send(await this.prisma.nagoya.findMany());
  }

  @Get('addData')
  async setDBData(){
      let a = new Date(2021,6,1);
      let b = new Date(2021,6,2);
      let c = new Date(2021,6,3);
      let d = new Date(2021,6,4);
      let e = new Date(2021,6,5);
      let f = new Date(2021,6,6);
      let g = new Date(2021,6,7);
      await this.prisma.nagoya.create({
          data:{
              day: a,
              day_of_week: "Tuesday",
              weather: "sunny",
              temperature: 30.0,
              rainy_percent: 10
          }
      });
      await this.prisma.nagoya.create({
          data:{
              day: b,
              day_of_week: "Wednesday",
              weather: "sunny",
              temperature: 30.0,
              rainy_percent: 10
          }
      });
      await this.prisma.nagoya.create({
          data:{
              day: c,
              day_of_week: "Thursday",
              weather: "sunny",
              temperature: 30.0,
              rainy_percent: 10
          }
      });
      await this.prisma.nagoya.create({
          data:{
              day: d,
              day_of_week: "Friday",
              weather: "cloud",
              temperature: 30.0,
              rainy_percent: 10
          }
      });
      await this.prisma.nagoya.create({
          data:{
              day: e,
              day_of_week: "Staturday",
              weather: "sunny",
              temperature: 28.0,
              rainy_percent: 40
          }
      });
      await this.prisma.nagoya.create({
          data:{
              day: f,
              day_of_week: "Sunday",
              weather: "sunny",
              temperature: 30.0,
              rainy_percent: 30
          }
      });
      await this.prisma.nagoya.create({
          data:{
              day: g,
              day_of_week: "Monday",
              weather: "sunny",
              temperature: 31.0,
              rainy_percent: 5
          }
      });
  }
}
