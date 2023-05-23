/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
/* eslint-disable @typescript-eslint/no-unused-vars */

import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { createDto } from "src/notification/dto";
import { updateDto } from "src/notification/dto/notification.update.dto";


@Injectable()
export class PaymentService {
    constructor(private prisma: PrismaService) {}


    get_payments() {

    }

    send_payment(dto: createDto) {

    }


    update_payment(dto:updateDto) {

    }


    

    delete_payment(userId) {

    }
    
}