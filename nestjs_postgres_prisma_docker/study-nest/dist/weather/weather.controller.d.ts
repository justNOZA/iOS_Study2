import { AppService } from 'src/app.service';
export declare class WeatherController {
    private readonly appService;
    constructor(appService: AppService);
    getWeather(res: any): void;
}
