import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { createDto, updateDto } from "./dto";

@Injectable()
export class NotificationService {
    constructor(private prisma: PrismaService) {}


    get_notifications() {

    }

    send_notification(dto: createDto) {

    }


    update_notification(dto:updateDto) {

    }


    generate_notification(dto:createDto) {

    }

    delete_notification(userId) {

    }
    
}