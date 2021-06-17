import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { Prisma, region } from '@prisma/client';

@Injectable()
export class RegionService {
    constructor(private prisma: PrismaService){}

    async region(regionWhereUniqueInput: Prisma.regionWhereUniqueInput): Promise<region | null>{
        return this.prisma.region.findUnique({
            where: regionWhereUniqueInput
        });
    }
    async regions(params: {
            skip?: number;
            take?: number;
            cursor?: Prisma.regionWhereUniqueInput;
            where?: Prisma.regionWhereInput;
            orderBy?: Prisma.regionOrderByInput;
            select?: Prisma.regionSelect;
        }): Promise<{}[]> {
        const { skip, take, cursor, where, orderBy, select} = params;
        return this.prisma.region.findMany({
            skip,
            select,
            take,
            cursor,
            where,
            orderBy,
        });
    }
    
    async createRegion(data: Prisma.regionCreateInput): Promise<region> {
        return this.prisma.region.create({
            data,
        });
    }
    
    async updateRegion(params: {
            where: Prisma.regionWhereUniqueInput;
            data: Prisma.regionUpdateInput;
        }): Promise<region> {
        const { data, where } = params;
        return this.prisma.region.update({
            data,
            where,
        });
    }
    
    async deleteRegion(where: Prisma.regionWhereUniqueInput): Promise<region> {
        return this.prisma.region.delete({
            where,
        });
    }
}
