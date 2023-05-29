/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, ParseIntPipe, Patch, Post, Put, UploadedFiles, UseGuards, UseInterceptors } from "@nestjs/common";
import { PaymentService } from "./payment.service";
import { createDto, updateDto } from "src/payment/dto";
import { Roles } from "src/decorators/role.auths";
import { Role } from "src/decorators/role.enum";
import { AtGuards } from "src/Authentication/gaurds/at.guards";
import { RolesGuard } from "src/Authentication/gaurds/role.gaurd";
import { FileFieldsInterceptor } from "@nestjs/platform-express";
import { createPhotoDto } from "./dto";
import { ImageStorage } from "src/helper/photo.storage";

@Controller('payment')
export class PaymentController {
    constructor(private paymentservice: PaymentService) {}
    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Get()
    get_payments() {
        return this.paymentservice.get_payments()
    }

    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Get(":id")
    get_payments_byId_admin(@Param('id',ParseIntPipe) id:number) {
        return this.paymentservice.get_payments_byId_admin(id)
    }


  

   @Roles(Role.CUSTOMER)
   @UseGuards(AtGuards, RolesGuard)
   @Post(':id')
   @UseInterceptors(
     FileFieldsInterceptor(
       [
        
         { name: "bill", maxCount: 1 },
         
        
       ],ImageStorage ))
 send_payment( @Param('id',ParseIntPipe) id:number,
 @Body() dto:createDto,
 @Body() photo:createPhotoDto,
 @UploadedFiles() file: Array<Express.Multer.File>){
     photo.bill=`http://localhost:3000/insurance/${file["bill"][0].filename}`; 
     
     return this.paymentservice.send_payment(id,dto,photo);
   }


    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Patch(":payment_id/approval")
    update_payment(@Param('payment_id',ParseIntPipe) payment_id:number, @Body() dto: updateDto) {
        return this.paymentservice.update_payment(payment_id, dto)
    }

    @Delete(":payment_id")
    delete_payment(@Param('payment_id',ParseIntPipe) payment_id:number) {
        return this.paymentservice.delete_payment(payment_id)
    }
 }