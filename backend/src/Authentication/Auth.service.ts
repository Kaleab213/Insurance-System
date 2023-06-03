/* eslint-disable prettier/prettier */
import { ForbiddenException, Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { CreateAuthDto } from "./dto";
import * as argon2 from "argon2";
import { JwtService } from "@nestjs/jwt";
import { ConfigService } from "@nestjs/config";
import { JwtPayload, Tokens } from "./types";

import { CreateCustomer } from "src/customers/dto/create.dto";

@Injectable()
export class AuthService {
  constructor(private prisma: PrismaService,private jwtService:JwtService,private config:ConfigService) {}

 



// ADMIN SIGNUP
  async adminsignup(dto: CreateAuthDto): Promise<Tokens> {
    const hash=await argon2.hash(dto.password)
    try {
      const user = await this.prisma.user.create({
        data: {
          firstName: dto.firstName,
          lastName: dto.lastName,
          email: dto.email,
          hash,
          role: 'ADMIN',
        },
      });


      const tokens = await this.GetToken(user.id, user.email,user.role);
      await this.updateRtHash(user.id, tokens.refresh_token);
  
      return tokens;

    } catch (error) {
      if (error.code === "P2002"&& error.meta?.target?.includes("email")) {
        throw new ForbiddenException("Email is already taken");
      }
     
    }
    
  }


  // Customer Signup
  async CustomerSignup(createUserDto:CreateAuthDto,CustomerDto:CreateCustomer): Promise<Tokens> {
    const hash = await argon2.hash(createUserDto.password);
    // const role=User.Roles
    const NewUser = await this.prisma.user.create({ 
      data: {
        email: createUserDto.email,
         firstName: createUserDto.firstName,
         lastName: createUserDto.lastName,
        hash: hash,
        role: 'CUSTOMER',
        costumers: {
          create:{
            phone:CustomerDto.phone,
            account_no:CustomerDto.account_no
          }
        }
        },
      
    });
   
    const tokens = await this.GetToken(
      NewUser.id,
    NewUser.email,
    NewUser.role
    );
    await this.updateRtHash(NewUser.id, tokens.refresh_token);
    return tokens;
  }






// SIGNIN USER


  async signin(dto:CreateAuthDto): Promise<Tokens>  {


    try{
 
    const user=await this.prisma.user.findUnique({
      where:{
        email:dto.email,}})
      if(!user)
        throw new ForbiddenException("Credentials are not valid")
    const isMatch=await argon2.verify(
       user.hash,
      dto.password,)

      
    if (!isMatch)
      throw new ForbiddenException("credentials are not valid");
    
    
    



    const tokens = await this.GetToken(user.id, user.email,user.role);
    await this.updateRtHash(user.id, tokens.refresh_token);
    const res = {access_token:tokens.access_token, refresh_token:tokens.refresh_token, role:user.role}

    return res;
  }
    catch (err) {
      throw new  ForbiddenException("Invalid Credentials")
    }
    
  }

  // LOGOUT

  async logout(userId: number): Promise<boolean> {
    await this.prisma.user.updateMany({
      where: {
        id: userId,
        hashRT: {
          not: null,
        },
      },
      data: {
        hashRT: null,
      },
    });
    return true;
  }

async getProfile(id:number){
  const user = await this.prisma.user.findUnique({
    where: {
      id,
    },
    include: {
      costumers: true,
     
},
 


  })
  delete user.hash;
  delete user.hashRT;
  return user;

}

 async edit_costumer(userId, dtouser) {

  const hash = await argon2.hash(dtouser.password);
    // const role=User.Roles
    const NewUser = await this.prisma.user.update({ 
      where: {
          id: userId,
      },
      data: {
        email: dtouser.email,
         firstName: dtouser.firstName,
         lastName: dtouser.lastName,
        hash: hash,
        
        }
        },
      
    );
   
    const tokens = await this.GetToken(
      NewUser.id,
    NewUser.email,
    NewUser.role
    );
    await this.updateRtHash(NewUser.id, tokens.refresh_token);
    return tokens;

 }


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
      throw new ForbiddenException((`no user is found`));
    }
  }
  





  async GetToken(userId: number, email: string, role:string){
    const jwtPayload: JwtPayload = {
      id: userId,
      email: email,
     role:role,
      
      
    };


    const [at, rt] = await Promise.all([
      this.jwtService.signAsync(jwtPayload, {
        secret: this.config.get<string>('AT_SECRET'),
        expiresIn: '7d',
      }),
      this.jwtService.signAsync(jwtPayload, {
        secret: this.config.get<string>('RT_SECRET'),
        expiresIn: '7d',
      }),
    ]);

    return {
      access_token: at,
      refresh_token: rt,
    };
  }


  async updateRtHash(userId: number, rt: string): Promise<void> {
    const hash = await argon2.hash(rt);
    await this.prisma.user.update({
      where: {
        id: userId,
      },
      data: {
      hashRT: hash
      },
    });
  }

}
