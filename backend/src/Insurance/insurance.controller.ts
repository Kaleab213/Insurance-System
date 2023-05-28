/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, ParseIntPipe, Patch, Post,  Res,  UploadedFile,  UploadedFiles,  UseGuards, UseInterceptors } from "@nestjs/common";
import { InsuranceService } from "./insurance.service";
import { CreateInsuranceDto, CreateInsurancePhotoDto } from "./dto/dto.create.insurance";
import { UpdateInsuranceDto } from "./dto/update.insurance.dto";
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


  @Post('upload')
  @UseInterceptors(FileInterceptor('file',{
    storage:diskStorage({
      destination:'./photos',
      filename:(req,file,cb)=>{
        const filename=file.originalname.split('.')[0];
        const fileExtension=file.originalname.split('.')[1];
        const newFilename=filename.split(' ').join('_')+'_'+Date.now()+'.'+fileExtension;
        cb(null,newFilename);
      },
      
  }),
  fileFilter:(req,file,cb)=>{
    if (!file.originalname.match(/\.(jpg|png|gif|jpeg)$/)){
      cb(null,false);
    }
    cb(null,true);

  }
  }))
  uploadFiles(@UploadedFile() license:Express.Multer.File){
    console.log(license);
    return `http://localhost:3000/insurance/${license.filename}`;
  }
  @Get(':filename')
  async getPhoto(@Param('filename') filename,@Res() res:Response){
    res.sendFile(filename,{root:'./photos'});

  }
   @Roles(Role.CUSTOMER)
   @UseGuards(AtGuards, RolesGuard)
  @Post()
  // @UseInterceptors(
  //   FileFieldsInterceptor(
  //     [
  //       { name: "license", maxCount: 1 },
  //     ],
  //     { storage: ImageStorage }
  //   )
  // )
  
   

  @UseInterceptors(FileInterceptor('file',{
    storage:diskStorage({
      destination:'./photos',
      filename:(req,file,cb)=>{
        const filename=file.originalname.split('.')[0];
        const fileExtension=file.originalname.split('.')[1];
        const newFilename=filename.split(' ').join('_')+'_'+Date.now()+'.'+fileExtension;
        cb(null,newFilename);
      },
      
  }),
  fileFilter:(req,file,cb)=>{
    if (!file.originalname.match(/\.(jpg|png|gif|jpeg)$/)){
      cb(null,false);
    }
    cb(null,true);

  }
  }))
  createInsurance( @GetUser() userId:number,
@Body() dto:CreateInsuranceDto,
@Body() photo:CreateInsurancePhotoDto,
  @UploadedFile()file:Express.Multer.File){
    photo.Document=`http://localhost:3000/insurance/${file.filename}`;
    console.log(photo.Document);
    
    return this.insurance.createInsurance(userId['id'],dto,photo);
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