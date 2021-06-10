import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { WeatherController } from './weather/weather.controller';

import { PrismaService } from './prisma/prisma.service';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [PrismaModule, PrismaModule],
  controllers: [AppController, WeatherController],
  providers: [AppService, PrismaService],
  exports: [],
})
export class AppModule {}
