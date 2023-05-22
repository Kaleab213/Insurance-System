import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { createDto, updateDto } from "./dto";

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