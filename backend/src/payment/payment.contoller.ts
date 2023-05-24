/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Post, Put } from "@nestjs/common";
import { PaymentService } from "./payment.service";
import { updateDto } from "src/notification/dto/notification.update.dto";
import { createDto } from "src/notification/dto";

@Controller("payment")
export class PaymentController {
    constructor(private paymentservice: PaymentService) {}

    @Get()
    get_payments() {
        return this.paymentservice.get_payments()
    }

    @Post()
    send_payment(@Body() dto: createDto) {
        return this.paymentservice.send_payment(dto)
    }

    @Put()
    update_payment(@Body() dto: updateDto) {
        return this.paymentservice.update_payment(dto)
    }

    @Delete()
    delete_payment(userId: any) {
        return this.paymentservice.delete_payment(userId)
    }
 }