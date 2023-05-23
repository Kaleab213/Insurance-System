import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";

@Injectable()
export class RequestService {
    constructor(private prisma: PrismaService) {}
    get_notifications() {

    }

    send_requests(dto: createDto) {

    }


    update_request(dto:updateDto) {

    }


    generate_request(dto:createDto) {

    }

    delete_request(userId) {

    }
    
}
