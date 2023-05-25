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
    async get_requests() {
        const requests = await this.prisma.coverage_request.findMany({
            where: {
        
              status: false
            },
          
      
          })
          return requests;

    }

    async get_requestsby_id(id) {

        const request = await this.prisma.coverage_request.findFirst({
            where: {
              id,
              status: false
            },
            include: {
                insurance: {
                    select: {
                        type:true,
                        size:true,
                        monthly_payment:true,
                        deposit:true,


                    }
                }
            }
          
      
          })
          return request;

    }

    async send_requests(dto: createDto) {

    }


    async update_request(id:number, dto:updateDto) {

        const approval =await this.prisma.coverage_request.update({
            where: {
              id,
            },
            data: {...dto},
            include: {
                insurance:
                {
                    select: {
                        userId:true,
                        level:true
                    }
                }
            }
          })
        const approve_notification = "dear custmer, you coverage payment is approved"
        const disapprove_notification = "dear customer, your coverage payment is disapproved"
        const userId = approval.insurance.userId
        const insuranceId = approval.insuranceId
          if (dto.status) {
                const notification = await this.prisma.notification.create({
   
                    data:{
                    insuranceId,
                    userId,
                    title:"coverage approval message",
                    description:approve_notification,}})
                const insurance = await this.prisma.user_Insurance.update({
                    where: {
                      id,
                    },
                    data: {deposit: {
                        decrement: approval.loss * approval.insurance.level,
                    }
                    
                  }})
                  
          }
          else {
            const notification = await this.prisma.notification.create({
   
                data:{
                insuranceId,
                userId,
                title:"coverage request disapproval message",
                description:disapprove_notification,}})
          }
          return approval;
        


    }


    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    generate_request(dto:createDto) {

    }

    delete_request(userId) {

    }
    
}
