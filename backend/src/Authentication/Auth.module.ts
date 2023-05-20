/* eslint-disable prettier/prettier */

import { Module } from "@nestjs/common";
import { AuthController } from "./Auth.controller";
import { AuthService } from "./Auth.service";
import { PrismaModule } from "src/Prisma/prisma.module";


@Module({
  imports:[PrismaModule],
  controllers: [AuthController],
  providers:[AuthService]
})
export class AuthModule{}