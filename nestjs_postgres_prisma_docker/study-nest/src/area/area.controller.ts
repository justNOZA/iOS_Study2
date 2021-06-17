import {  Body, Controller, Get, Post, Res } from '@nestjs/common';
import { RegionService } from 'src/region/region.service';

let result_success = require('../../json/success.json');
@Controller('area')
export class AreaController {
    constructor(
        private readonly regionService: RegionService
    ){}

    @Get('list')
    async getAreaList(@Res() res){
        res.status(200);
        
        var datas = await this.regionService.regions({
            select: {
                area_id:true,
                area_name:true
            }
        });
        let success = {"result":"success", "datas":[]};
        success.datas = datas;
        var data = JSON.stringify(success);
        
        data = data.replace(/area_id/g,"areaID");
        data = data.replace(/area_name/g,"areaName");
        res.send(JSON.parse(data));
    }

    @Post("add")
    async setArea(@Body() body, @Res() res){
        let area_name = body.areaName;
        var result = await this.regionService.createRegion({
            area_name
        });
        res.status(200);
        res.send(result_success);
    }

    @Post("edit")
    async updateArea(@Body() body, @Res() res){
        let name = body.areaName;
        let id = body.areaID;
        var result = await this.regionService.updateRegion({
            where: {area_id: id},
            data: {area_name: name}
        });
        res.status(200);
        res.send(result_success);
    }

}