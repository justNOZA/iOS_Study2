import { RegionService } from 'src/region/region.service';
export declare class AreaController {
    private readonly regionService;
    constructor(regionService: RegionService);
    getAreaList(res: any): Promise<void>;
    setArea(body: any, res: any): Promise<void>;
    updateArea(body: any): Promise<void>;
}
