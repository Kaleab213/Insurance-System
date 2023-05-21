/* eslint-disable prettier/prettier */

import { Module } from "@nestjs/common";
import { AuthController } from "./Auth.controller";
import { AuthService } from "./Auth.service";
import { PrismaModule } from "src/Prisma/prisma.module";
import { JwtModule } from "@nestjs/jwt";
import { RolesGuard } from "./gaurds/role.gaurd";
import { RtStrategy } from "./strategy/rt.strategy";
import { AtStrategy } from "./strategy/at.strategy";


@Module({
  imports:[PrismaModule,JwtModule.register({})],
  controllers: [AuthController],
  providers:[AuthService,AtStrategy,RtStrategy,RolesGuard]
})
export class AuthModule{}