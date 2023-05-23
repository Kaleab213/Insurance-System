/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { CreateInsuranceDto } from "./dto/dto.create.insurance";
import { UpdateInsuranceDto } from "./dto/update.insurance.dto";

@Injectable()
export class InsuranceService{
  constructor(private prisma:PrismaService){}
  async createInsurance(userId:number,dto:CreateInsuranceDto){
    const insurance=await this.prisma.user_Insurance.create({
   
      data:{
       
        userId:userId,
        ...dto,}})
    return insurance;
  }
  async getInsurance(){
    const insurance= await this.prisma.user_Insurance.findMany({

    })
    return insurance;
  }
  async getInsuranceById(insuranceId:number){
    const insurance=await this.prisma.user_Insurance.findUnique({
      where: {
        id:insuranceId
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
    const insurance=await this.prisma.user_Insurance.delete({
      where: {
        id:insuranceId
      }})
    return insurance;
  }
}