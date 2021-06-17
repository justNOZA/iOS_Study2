import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService} from './app.service';
import { WeatherController } from './weather/weather.controller';
import { AreaController } from './area/area.controller';
import { PrismaService } from './prisma/prisma.service';
import { RegionService } from './region/region.service';

@Module({
  imports: [],
  controllers: [AppController, WeatherController, AreaController],
  providers: [AppService, PrismaService, RegionService],
  exports: [PrismaService],
})
export class AppModule {}
