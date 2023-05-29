/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, ParseIntPipe, Patch, Post, Put, UploadedFiles, UseGuards, UseInterceptors } from "@nestjs/common";
import { RequestService } from "./request.service";
import { createDto } from "src/request/dto/request.create.dto";
import { updateDto } from "src/request/dto";
import { CreateAuthDto } from "src/Authentication/dto";
import { Roles, } from "src/decorators/role.auths";
import { AtGuards } from "src/Authentication/gaurds/at.guards";
import { RolesGuard } from "src/Authentication/gaurds/role.gaurd";
import { Role } from "src/decorators/role.enum";
import { FileFieldsInterceptor } from "@nestjs/platform-express/multer";
import { ImageStorage } from "src/helper/photo.storage";
import { GetUser } from "src/decorators";
import { CreateRequestPhotoDto } from "./dto";

@Controller("request")
export class RequestController {
    constructor(private requestservice: RequestService) {}

    
    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Get()
    get_requests() {
            return this.requestservice.get_requests();
        }


    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Get(":request_id")
    get_requestsby_Id(@Param('request_id',ParseIntPipe) request_id:number) {
        return this.requestservice.get_requestsby_id(request_id);
    }

    @Roles(Role.CUSTOMER)
    @UseGuards(AtGuards, RolesGuard)
   @Post(":insurance_id")
   @UseInterceptors(
     FileFieldsInterceptor(
       [
        
         { name: "police_report", maxCount: 1 },
         { name: "supported_document", maxCount: 1 },
        
       ],ImageStorage ))
 send_request( @Param('insurance_id',ParseIntPipe) insurance_id:number,
 @Body() dto:createDto,
 @Body() photo:CreateRequestPhotoDto,
 @UploadedFiles() file: Array<Express.Multer.File>){
     photo.police_report=`http://localhost:3000/insurance/${file["police_report"][0].filename}`; 
     photo.supported_document=`http://localhost:3000/insurance/${file["supported_document"][0].filename}`;
     
     return this.requestservice.send_requests(insurance_id,dto,photo);
   }


    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Patch(":request_id/approval")
    update_request(@Param('request_id',ParseIntPipe) request_id:number, @Body() dto: updateDto) {
        return this.requestservice.update_request(request_id, dto)
    }

    @Delete(":request_id")
    delete_request(@Param('request_id',ParseIntPipe) request_id:number) {
        return this.requestservice.delete_request(request_id)
    }
 }