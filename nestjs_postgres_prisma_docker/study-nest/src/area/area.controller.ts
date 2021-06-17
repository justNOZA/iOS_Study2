import {  Body, Controller, Get, Post, Res } from '@nestjs/common';
import { RegionService } from 'src/region/region.service';

var result_success = require('../../json/success.json');
@Controller('area')
export class AreaController {
    constructor(
        private readonly regionService: RegionService
    ){}

    @Get('list')
    async getAreaList(@Res() res){
        res.status(200);
        
        var datas = this.regionService.regions({
            
        });
        result_success.datas = datas;

        var data = JSON.stringify(result_success);

        data = data.replace(/area_id/g,"areaID");
        data = data.replace(/area_name/g,"areaName");
        res.send(JSON.parse(data));
    }

    @Post("add")
    async setArea(@Body() body){
        let area_name = body.areaName;
        return this.regionService.createRegion({
            area_name
        });
    }

    @Post("edit")
    async updateArea(@Body() body){
        let name = body.areaName;
        let id = body.areaID;
        return this.regionService.updateRegion({
            where: {area_id: id},
            data: {area_name: name}
        });
    }

}