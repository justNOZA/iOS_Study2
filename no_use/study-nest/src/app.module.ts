import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService, PrismaService } from './app.service';
import { WeatherController } from './weather/weather.controller';

@Module({
  imports: [],
  controllers: [AppController, WeatherController],
  providers: [AppService, PrismaService],
  exports: [PrismaService],
})
export class AppModule {}
