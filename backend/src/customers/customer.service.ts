/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable prettier/prettier */
import { ForbiddenException, Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { CreateCustomer } from "./dto/create.dto";
import { CreateAuthDto } from "src/Authentication/dto";
import * as argon2 from 'argon2';

@Injectable()
export class CustomerService {
  constructor(private prisma:PrismaService){}
  // async signup(dtoUser:CreateAuthDto,dtoCustomer:CreateCustomer){
  //   const hash=await argon2.hash(dtoUser.password);
  //  const customer=await this.prisma.costumers.create({
  
  //   data:{phone:dtoCustomer.phone,
  //     account_no:dtoCustomer.account_no,
  //     user:{
  //       create:{
  //        hash,
  //         firstName:dtoUser.firstName,
  //         lastName:dtoUser.lastName,
  //         email:dtoUser.email,
  //       }
  //     }
     
      
  //   },
    
  //  })
  //  return customer;
  // }


  async  signup(dtoUser:CreateAuthDto,dtoCustomer:CreateCustomer) {
    const hashs=await argon2.hash(dtoUser.password);
    try {
      const customer = await this.prisma.costumers.create({
        data:{phone:dtoCustomer.phone,
          account_no:dtoCustomer.account_no,
          user:{
            create:{
             
              firstName:dtoUser.firstName,
              lastName:dtoUser.lastName,
              email:dtoUser.email,
              hash:hashs,
            }
          }
         
          
        },
      });


      return customer;
      

    } catch (error) {
      if (error.code === "P2002"&& error.meta?.target?.includes("email")) {
        throw new ForbiddenException("Email is already taken");
      }
     
    }
    
  }












  
  login(){}
  logout(){}



  updateAccount(){}
  async deleteAccount(userId: number) {
    try {
      await this.prisma.user.delete({
        where: {
          id: userId, 
          // email:email// Assuming 'id' is the unique identifier for a user
        },
      });
    } catch (error) {
      // Handle any errors that occur during the deletion process
      throw new ForbiddenException((`Failed to delete account: ${error.message}`));
    }
  }
  


  
  getAccount(){}
}