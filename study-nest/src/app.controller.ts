import { Controller, Get, Res } from '@nestjs/common';
import { AppService } from './app.service';

var jsonData = require('../json/study.json');
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(@Res() res) {
    // this.appService.getHello()
    res.status(200).send(jsonData);
  }
}