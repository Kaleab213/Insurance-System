/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { CreateInsuranceDto, CreateInsurancePhotoDto } from "./dto/dto.create.insurance";
import { UpdateInsuranceDto } from "./dto/update.insurance.dto";

@Injectable()
export class InsuranceService{
  constructor(private prisma:PrismaService){}
  async createInsurance(userId:number,dto:CreateInsuranceDto,photo:CreateInsurancePhotoDto){
    const insurance = await this.prisma.user_Insurance.create({
          data: {
            userId,
          
            
            propertytype:dto.type,
            size:Number(dto.size),
            location:dto.location,
            coveragelevel:dto.level,
            deposit:Number(dto.deposit),
            room:Number(dto.room),
            Document:photo.Document,

            monthly_payment:dto.monthly_payment,
            
            
            
            
          } 
      })
    return insurance;
  }
  async getInsurance(userId){
    const insurance= await this.prisma.user_Insurance.findMany({
      where: {
        userId,
        status: true
      }

    }
    )
    return insurance;
  }
  async getInsuranceById(insuranceId:number){
    const insurance=await this.prisma.user_Insurance.findFirst({
      where: {
        id:insuranceId,
        status: true
      }

    })
    return insurance;

  }
  async updateInsurance(insuranceId:number,updateDto:UpdateInsuranceDto){
    const insurance=await this.prisma.user_Insurance.update({
      where: {
        id: insuranceId
      },
      data: {...updateDto}
    })
    return insurance;
  }

  async deleteInsurance(insuranceId:number){
    const insurance=await this.prisma.user_Insurance.findFirst({
      where:{id:insuranceId}
    })
    if (insurance){
    await this.prisma.user_Insurance.delete({
      where: {
        id:insuranceId
      }})
    return "Deleted Succesfully!!";}
    else{
      return 'No Houses found to Delete!!';
    }
  }
async gethousepayment(userId:number){
 const  payment= this.prisma.user_Insurance.findMany({
  where: {
  userId:userId,
    payments:{
      some: {
        status:true
      }
    },
    },
include:{
  payments:true
}
 })

 
}


}