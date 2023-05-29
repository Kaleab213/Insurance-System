/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
/* eslint-disable @typescript-eslint/no-unused-vars */

import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { createDto, updateDto } from "src/payment/dto";

import { createPhotoDto } from "./dto";


@Injectable()
export class PaymentService {
    constructor(private prisma: PrismaService) {}


    async get_payments() {
        const payments = await this.prisma.payment.findMany({
            where: {
        
              status: false
            },
          
      
          })
          return payments;

    }


    async get_payments_byId_admin(id:number) {
        const payments = await this.prisma.payment.findFirst({
            where: {
              id,
              status: false
            },
            include: {
                insurance: {
                    select: {
                        propertytype:true,
                        
                    }
                }
            }
          
      
          })
          return payments;

    }



  

    async send_payment(insuranceId: number, dto: createDto, photo: createPhotoDto) {
      const payment = await this.prisma.payment.create({
        data: {
          insuranceId,
          ...photo,
          ...dto,
          
        }
    });
    return payment 

    }


    async update_payment(id, dto:updateDto) {
        const approval =await this.prisma.payment.update({
            where: {
              id,
            },
            data: {...dto},
            include: {
                insurance:
                {
                    select: {
                        userId:true,
                        monthly_payment:true,
                       
                    }
                }
            }
          })

        const approve_notification = "dear custmer, you monthly payment is approved"
        const disapprove_notification = "dear customer, your monthly payment is disapproved"
        const userId = approval.insurance.userId
        const insuranceId = approval.insuranceId

          if (dto.status) {
                const notification = await this.prisma.notification.create({
   
                    data:{
                    insuranceId,
                    userId,
                    title:"Payment approval message",
                    description:approve_notification,}})
                const insurance = await this.prisma.user_Insurance.update({
                    where: {
                      id,
                    },
                    data: {deposit: {
                        increment: approval.insurance.monthly_payment,
                        
                    }
                    
                  }})
                  
          }
          else {
            const notification = await this.prisma.notification.create({
   
                data:{
                insuranceId,
                userId,
                title:"Payment disapproval message",
                description:disapprove_notification,}})
          }
          return approval;
        

        
            
    }


    

    async delete_payment(paymentId:number) {

      const requests = await this.prisma.coverage_request.delete({
        where: {
          id: paymentId,

        },
      })
    }
    
}