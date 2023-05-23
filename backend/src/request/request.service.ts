/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { createDto } from "src/notification/dto/notification.create.dto";
import { updateDto } from "src/notification/dto/notification.update.dto";

@Injectable()
export class RequestService {
    constructor(private prisma: PrismaService) {}
    // eslint-disable-next-line @typescript-eslint/no-empty-function
    get_notifications() {

    }

    send_requests(dto: createDto) {

    }


    update_request(dto:updateDto) {

    }


    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    generate_request(dto:createDto) {

    }

    delete_request(userId) {

    }
    
}
