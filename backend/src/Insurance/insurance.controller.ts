/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, ParseIntPipe, Patch, Post,  Res,  UploadedFile,  UploadedFiles,  UseGuards, UseInterceptors } from "@nestjs/common";
import { InsuranceService } from "./insurance.service";
import { CreateInsuranceDto, CreateInsurancePhotoDto } from "./dto/dto.create.insurance";
import { UpdateByAdminInsurance, UpdateInsuranceDto } from "./dto/update.insurance.dto";
import { GetUser } from "src/decorators";
import { AtGuards } from "src/Authentication/gaurds/at.guards";
import { RolesGuard } from "src/Authentication/gaurds/role.gaurd";

import { Roles } from "src/decorators/role.auths";
import { Role } from '../decorators/role.enum';
import { FileFieldsInterceptor, FileInterceptor } from "@nestjs/platform-express/multer";
import { ImageStorage } from "src/helper/photo.storage";
import { diskStorage } from "multer";
import { Response } from "express";

@Controller('insurance')
export class InsuranceController {
  constructor(private insurance:InsuranceService){}


  @Get(':filename')
  async getPhoto(@Param('filename') filename,@Res() res:Response){
    res.sendFile(filename,{root:'./photos'});

  }
   @Roles(Role.CUSTOMER)
   @UseGuards(AtGuards, RolesGuard)
  @Post()
  @UseInterceptors(
    FileFieldsInterceptor(
      [
       
        { name: "Document", maxCount: 1 },
       
      ],ImageStorage ))
createInsurance( @GetUser() userId:number,
@Body() dto:CreateInsuranceDto,
@Body() photo:CreateInsurancePhotoDto,
@UploadedFiles() file: Array<Express.Multer.File>){
    console.log(file, "here after create");
    photo.Document=`http://localhost:3000/insurance/${file["Document"]}`;
    
    
    return this.insurance.createInsurance(userId['id'],dto,photo);
  }
 



@Roles(Role.CUSTOMER)
@UseGuards(AtGuards, RolesGuard)
@Get()
  getInsurance(@GetUser() userId:number){
    return this.insurance.getInsurance(userId['id']);
  }

  @Roles(Role.CUSTOMER)
  @UseGuards(AtGuards, RolesGuard)
  @Get(':id/detail')
 getInsuranceById(@GetUser() userId:number,@Param('id',ParseIntPipe) id:number){
  return this.insurance.getInsuranceById(userId['id'],id);
 }


 @Patch(':id')
updateInsurance(@Param('id',ParseIntPipe) id:number,@Body() updateDto:UpdateInsuranceDto){
  return this.insurance.updateInsurance(id,updateDto);
}


@Delete(':id')
 deleteInsurance(@Param('id',ParseIntPipe) id:number){
  return this.insurance.deleteInsurance(id);
 }



//  ADMIN ROLES
@Roles(Role.ADMIN)
@UseGuards(AtGuards, RolesGuard)
@Get("admin/get")
getInsurancebyAdmin(){
  return this.insurance.getInsuranceBYAdmin();
}


@Roles(Role.ADMIN)
@UseGuards(AtGuards, RolesGuard)
@Get(':id/admin')
getInsurancebyAdminById(@Param('id',ParseIntPipe) id:number){
  return this.insurance.getInsuranceBYAdminById(id);

}

@Roles(Role.ADMIN)
@UseGuards(AtGuards, RolesGuard)
@Patch(':id/approval')
@UseInterceptors(
  FileFieldsInterceptor(
    [
     
      { name: "telebirr_QR", maxCount: 1 },
     
    ],ImageStorage ))
approveInsuranceByAdmin(@Param('id',ParseIntPipe) id:number,@Body() updateDto:UpdateByAdminInsurance,@UploadedFiles() file: Array<Express.Multer.File>){
  updateDto.telebirr_QR=`http://localhost:3000/insurance/${file["telebirr_QR"].filename}`;
  return this.insurance.ApproveInsuranceBYAdmin(id,updateDto);}


}