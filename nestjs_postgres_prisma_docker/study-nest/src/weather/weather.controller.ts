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
//   @Get('nagoya2')
//   async getDBWeather(@Res() res){
//       res.status(200);
//       res.send(await this.prisma.nagoya.findMany());
//   }

//   @Get('addData')
//   async setDBData(){
//       let a = new Date(2021,6,1);
//       await this.prisma.nagoya.create({
//           data:{
//               day: a,
//               day_of_week: "Tuesday",
//               weather: "sunny",
//               temperature: 30.0,
//               rainy_percent: 10
//           }
//       });
//   }
}
