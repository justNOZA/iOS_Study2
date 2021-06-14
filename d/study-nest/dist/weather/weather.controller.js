"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.WeatherController = void 0;
const common_1 = require("@nestjs/common");
const app_service_1 = require("../app.service");
var wjsonData = require("../../json/weather.json");
let WeatherController = class WeatherController {
    constructor(appService, prisma) {
        this.appService = appService;
        this.prisma = prisma;
    }
    getWeather(res) {
        res.status(200).send(wjsonData);
    }
    async getDBWeather(res) {
        res.status(200);
        res.send(await this.prisma.nagoya.findMany());
    }
    async setDBData() {
        let a = new Date(2021, 6, 1);
        let b = new Date(2021, 6, 2);
        let c = new Date(2021, 6, 3);
        let d = new Date(2021, 6, 4);
        let e = new Date(2021, 6, 5);
        let f = new Date(2021, 6, 6);
        let g = new Date(2021, 6, 7);
        await this.prisma.nagoya.create({
            data: {
                day: a,
                day_of_week: "Tuesday",
                weather: "sunny",
                temperature: 30.0,
                rainy_percent: 10
            }
        });
        await this.prisma.nagoya.create({
            data: {
                day: b,
                day_of_week: "Wednesday",
                weather: "sunny",
                temperature: 30.0,
                rainy_percent: 10
            }
        });
        await this.prisma.nagoya.create({
            data: {
                day: c,
                day_of_week: "Thursday",
                weather: "sunny",
                temperature: 30.0,
                rainy_percent: 10
            }
        });
        await this.prisma.nagoya.create({
            data: {
                day: d,
                day_of_week: "Friday",
                weather: "cloud",
                temperature: 30.0,
                rainy_percent: 10
            }
        });
        await this.prisma.nagoya.create({
            data: {
                day: e,
                day_of_week: "Staturday",
                weather: "sunny",
                temperature: 28.0,
                rainy_percent: 40
            }
        });
        await this.prisma.nagoya.create({
            data: {
                day: f,
                day_of_week: "Sunday",
                weather: "sunny",
                temperature: 30.0,
                rainy_percent: 30
            }
        });
        await this.prisma.nagoya.create({
            data: {
                day: g,
                day_of_week: "Monday",
                weather: "sunny",
                temperature: 31.0,
                rainy_percent: 5
            }
        });
    }
};
__decorate([
    common_1.Get('nagoya'),
    __param(0, common_1.Res()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], WeatherController.prototype, "getWeather", null);
__decorate([
    common_1.Get('nagoya2'),
    __param(0, common_1.Res()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], WeatherController.prototype, "getDBWeather", null);
__decorate([
    common_1.Get('addData'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], WeatherController.prototype, "setDBData", null);
WeatherController = __decorate([
    common_1.Controller('weather'),
    __metadata("design:paramtypes", [app_service_1.AppService,
        app_service_1.PrismaService])
], WeatherController);
exports.WeatherController = WeatherController;
//# sourceMappingURL=weather.controller.js.map