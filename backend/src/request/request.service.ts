/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { createDto } from "src/request/dto/request.create.dto";
import { updateDto } from "src/request/dto/request.update.dto";
import { CreateRequestPhotoDto } from "./dto";

@Injectable()
export class RequestService {
    constructor(private prisma: PrismaService) {}
    // eslint-disable-next-line @typescript-eslint/no-empty-function
    async get_requests() {
        const requests = await this.prisma.coverage_request.findMany({
            where: {
        
              status: false
            },
            take: 30,
      
          })
          return requests;

    }

    async get_requestsby_id(id:number) {

        const request = await this.prisma.coverage_request.findFirst({
            where: {
              insuranceId:id,
              
              status: false
            },
            include: {
                insurance: {
                    select: {
                        propertytype:true,
                        size:true,
                        monthly_payment:true,
                        deposit:true,


                    }
                }
            }
          
      
          })
          return request;

    }

    async send_requests(insuranceId:number, dto: createDto, photo: CreateRequestPhotoDto) {

      const request = await this.prisma.coverage_request.create({
        data: {
          insuranceId,
          ...dto,
          ...photo,
          
        }
    })
    return request

    }


    async update_request(id:number, dto:updateDto) {
        const coverage_dict = {"1": 0.75, "2": 0.65, "3": 0.5, "4": 0.25}

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
                        coveragelevel:true
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
                        decrement: approval.loss * coverage_dict[approval.insurance.coveragelevel]
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

    async delete_request(requestId:number) {
      const requests = await this.prisma.coverage_request.delete({
        where: {
          id: requestId ,

        },
      })
      

    }
    
}
