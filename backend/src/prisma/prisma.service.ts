/* eslint-disable prettier/prettier */
import { Injectable } from "@nestjs/common";
import { ConfigService } from "@nestjs/config/dist";
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient{
  constructor(config:ConfigService){
    super({
      datasources:{
        db: {
          url:config.get('DATABASE_URL')
        }
      }
    });
  }
}