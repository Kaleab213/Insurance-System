/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put, UseGuards } from "@nestjs/common";
import { PaymentService } from "./payment.service";
import { updateDto } from "src/notification/dto/notification.update.dto";
import { createDto } from "src/notification/dto";
import { Roles } from "src/decorators/role.auths";
import { Role } from "src/decorators/role.enum";
import { AtGuards } from "src/Authentication/gaurds/at.guards";
import { RolesGuard } from "src/Authentication/gaurds/role.gaurd";

@Controller("payment")
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
    @Get(":id/admin")
    get_payments_byId_admin(@Param('id',ParseIntPipe) id:number) {
        return this.paymentservice.get_payments_byId_admin(id)
    }


  

    @Post()
    send_payment(@Body() dto: createDto) {
        return this.paymentservice.send_payment(dto)
    }


    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Put(":payment_id/approval")
    update_payment(@Param('payment_id',ParseIntPipe) payment_id:number, @Body() dto: updateDto) {
        return this.paymentservice.update_payment(payment_id, dto)
    }

    @Delete()
    delete_payment(userId: any) {
        return this.paymentservice.delete_payment(userId)
    }
 }