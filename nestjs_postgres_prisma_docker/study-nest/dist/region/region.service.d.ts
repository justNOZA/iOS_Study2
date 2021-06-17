import { PrismaService } from 'src/prisma/prisma.service';
import { Prisma, region } from '@prisma/client';
export declare class RegionService {
    private prisma;
    constructor(prisma: PrismaService);
    region(regionWhereUniqueInput: Prisma.regionWhereUniqueInput): Promise<region | null>;
    regions(params: {
        skip?: number;
        take?: number;
        cursor?: Prisma.regionWhereUniqueInput;
        where?: Prisma.regionWhereInput;
        orderBy?: Prisma.regionOrderByInput;
        select?: Prisma.regionSelect;
    }): Promise<{}[]>;
    createRegion(data: Prisma.regionCreateInput): Promise<region>;
    updateRegion(params: {
        where: Prisma.regionWhereUniqueInput;
        data: Prisma.regionUpdateInput;
    }): Promise<region>;
    deleteRegion(where: Prisma.regionWhereUniqueInput): Promise<region>;
}
