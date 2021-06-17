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
exports.AreaController = void 0;
const common_1 = require("@nestjs/common");
const region_service_1 = require("../region/region.service");
let result_success = require('../../json/success.json');
let AreaController = class AreaController {
    constructor(regionService) {
        this.regionService = regionService;
    }
    async getAreaList(res) {
        res.status(200);
        var datas = await this.regionService.regions({
            select: {
                area_id: true,
                area_name: true
            }
        });
        let success = { "result": "success", "datas": [] };
        success.datas = datas;
        var data = JSON.stringify(success);
        data = data.replace(/area_id/g, "areaID");
        data = data.replace(/area_name/g, "areaName");
        res.send(JSON.parse(data));
    }
    async setArea(body, res) {
        let area_name = body.areaName;
        var result = await this.regionService.createRegion({
            area_name
        });
        console.log(result);
        res.status(200);
        res.send(result_success);
    }
    async updateArea(body) {
        let name = body.areaName;
        let id = body.areaID;
        var result = await this.regionService.updateRegion({
            where: { area_id: id },
            data: { area_name: name }
        });
        console.log(result);
    }
};
__decorate([
    common_1.Get('list'),
    __param(0, common_1.Res()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], AreaController.prototype, "getAreaList", null);
__decorate([
    common_1.Post("add"),
    __param(0, common_1.Body()), __param(1, common_1.Res()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], AreaController.prototype, "setArea", null);
__decorate([
    common_1.Post("edit"),
    __param(0, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], AreaController.prototype, "updateArea", null);
AreaController = __decorate([
    common_1.Controller('area'),
    __metadata("design:paramtypes", [region_service_1.RegionService])
], AreaController);
exports.AreaController = AreaController;
//# sourceMappingURL=area.controller.js.map