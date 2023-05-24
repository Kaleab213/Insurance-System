/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, ParseIntPipe, Patch, Post, UseGuards } from "@nestjs/common";
import { InsuranceService } from "./insurance.service";
import { CreateInsuranceDto } from "./dto/dto.create.insurance";
import { UpdateInsuranceDto } from "./dto/update.insurance.dto";
import { GetUser } from "src/decorators";
import { AtGuards } from "src/Authentication/gaurds/at.guards";
import { RolesGuard } from "src/Authentication/gaurds/role.gaurd";

import { Roles } from "src/decorators/role.auths";
import { Role } from '../decorators/role.enum';

@Controller('insurance')
export class InsuranceController {
  constructor(private insurance:InsuranceService){}
   @Roles(Role.CUSTOMER)
   @UseGuards(AtGuards, RolesGuard)
  @Post()
  createInsurance(@GetUser() userId:number,@Body() dto:CreateInsuranceDto){
    return this.insurance.createInsurance(userId['id'],dto);
  }

@Roles(Role.CUSTOMER)
@UseGuards(AtGuards, RolesGuard)
@Get()
  getInsurance(@GetUser() userId:number){
    return this.insurance.getInsurance(userId);
  }


  @Get(':id')
 getInsuranceById(@Param('id',ParseIntPipe) id:number){
  return this.insurance.getInsuranceById(id);
 }


 @Patch('update/:id')
updateInsurance(@Param('id',ParseIntPipe) id:number,@Body() updateDto:UpdateInsuranceDto){
  return this.insurance.updateInsurance(id,updateDto);
}


@Delete('delete/:id')
 deleteInsurance(@Param('id',ParseIntPipe) id:number){
  return this.insurance.deleteInsurance(id);
 }
}