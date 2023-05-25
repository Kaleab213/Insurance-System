import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { createDto, updateDto } from "./dto";

@Injectable()
export class NotificationService {
    constructor(private prisma: PrismaService) {}


    async get_notifications(userId) {

        const notifications = await this.prisma.notification.findMany({
            where: {
              userId,
              
            },
            select: {
                updatedAt:true,
                title:true,
                status:true

            }
      
          }
          )
          return notifications;

    }

    async get_notifications_byid(userId, notification_id) {
        const notification = await this.prisma.notification.findFirst({
            where: {
             id:notification_id,
              userId,
            }
      
          }
          )
          return notification;

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