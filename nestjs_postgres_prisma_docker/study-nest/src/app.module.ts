import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService, PrismaService } from './app.service';
import { WeatherController } from './weather/weather.controller';
import { AreaController } from './area/area.controller';

@Module({
  imports: [],
  controllers: [AppController, WeatherController, AreaController],
  providers: [AppService, PrismaService],
  exports: [PrismaService],
})
export class AppModule {}
