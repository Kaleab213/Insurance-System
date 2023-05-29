import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { createDto, updateDto } from "./dto";

@Injectable()
export class NotificationService {
    constructor(private prisma: PrismaService) {}


    async get_notifications(userId:number) {

      const count = await this.prisma.notification.count({
        where: {
          status: false,
          userId,
        },
      });

        const notifications = await this.prisma.notification.findMany({
            where: {
              userId,
              
            },
            select: {
                updatedAt:true,
                title:true,
                status:true,

              

            }
      
          }
          )
          return {count:count, notification:notifications};

    }

    async get_notifications_byid(userId:number, notification_id:number) {
        const notification = await this.prisma.notification.findFirst({
            where: {
             id:notification_id,
             userId,
            }
      
          }
          )
          return notification;

    }

    async send_notification(userId:number, dto: createDto) {
      const request = await this.prisma.notification.create({
        data: {
          userId,
          ...dto,
          
        }
    })
    return request

    }


    async update_notification(userId:number, id:number, dto:updateDto) {
      const request = await this.prisma.coverage_request.update({

        where: {
          id,
          
        },
        data: {
          ...dto,
          
          
        }
    })
    return request
      

    }


    generate_notification(dto:createDto) {

    }

    async delete_notification(id:number) {
      const request = await this.prisma.coverage_request.delete({
        where: {
          id,
        }
    })
    return request
    }
    
}