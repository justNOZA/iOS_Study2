import { AppService, PrismaService } from 'src/app.service';
export declare class WeatherController {
    private readonly appService;
    private readonly prisma;
    constructor(appService: AppService, prisma: PrismaService);
    getWeather(res: any): void;
    getDBWeather(res: any): Promise<void>;
    setDBData(): Promise<void>;
}
