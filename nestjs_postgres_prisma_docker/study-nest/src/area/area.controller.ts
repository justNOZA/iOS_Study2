import {  Body, Controller, Get, Post, Query, Res } from '@nestjs/common';
import { AppService, PrismaService } from 'src/app.service';

var result_success = require('../../json/success.json');
@Controller('area')
export class AreaController {
    constructor(
        private readonly appService: AppService,
        private readonly prisma: PrismaService
    ){}

    @Get('list')
    async getAreaList(@Res() res){
        res.status(200);
        var datas = await this.prisma.region.findMany({
            select:{
                area_id: true,
                area_name: true
            }
        });
        result_success.datas = datas;

        var data = JSON.stringify(result_success);

        data = data.replace(/area_id/g,"areaID");
        data = data.replace(/area_name/g,"areaName");
        res.send(JSON.parse(data));
    }

    @Post("add")
    async setArea(@Res() res, @Body() body, @Query() query){
        // let name = query.areaName;
        let name = body.areaName;
        await this.prisma.region.create({
            data:{
                area_name: name
            }
        });
        res.status(200);
        res.send(result_success);
    }

    @Post("edit")
    async updateArea(@Res() res, @Body() body, @Query() query){
        // let name = query.areaName;
        // let id = parseInt(query.areaID);
        let name = body.areaName;
        let id = body.areaID;

        await this.prisma.region.update({
            where: {
                area_id: id
            },
            data:{
                area_name: name
            }
        });
        res.status(200);
        res.send(result_success);
    }

}