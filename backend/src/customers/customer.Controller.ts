/* eslint-disable prettier/prettier */
import { Controller, Delete, UseGuards } from "@nestjs/common";
import { CustomerService } from "./customer.service";
import { AtGuards } from "src/Authentication/gaurds/at.guards";
import { RolesGuard } from "src/Authentication/gaurds/role.gaurd";
import { Role } from "@prisma/client";
import { Roles } from "src/decorators/role.auths";
import { GetUserId } from "src/decorators";


@Controller('customer')
export class CustomerController{
  constructor(private customer:CustomerService){}

  // @Roles(Role.ADMIN)
  @UseGuards(AtGuards, RolesGuard)
  @Delete('deleted')
  deletedAccount(@GetUserId() userId: number){
    console.log(userId);
    
    return this.customer.deleteAccount(userId);
  }
}