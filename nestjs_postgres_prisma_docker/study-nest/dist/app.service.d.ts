import { OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
export declare class AppService {
    getHello(): string;
}
export declare class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
    constructor();
    onModuleInit(): Promise<void>;
    onModuleDestroy(): Promise<void>;
}
