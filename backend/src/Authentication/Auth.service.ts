/* eslint-disable prettier/prettier */
import { ConflictException, ForbiddenException, Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { CreateAuthDto } from "./dto";
import * as argon2 from "argon2";
import { JwtService } from "@nestjs/jwt";
import { ConfigService } from "@nestjs/config";
import { JwtPayload, Tokens } from "./types";
import { Roles } from "src/decorators/role.auths";
import { Role } from "src/decorators/role.enum";

@Injectable()
export class AuthService {
  constructor(private prisma: PrismaService,private jwtService:JwtService,private config:ConfigService) {}

  async getTokens(userId: number, email: string): Promise<Tokens> {
    const jwtPayload: JwtPayload = {
      id: userId,
      email: email,
      
    };

    const [at, rt] = await Promise.all([
      this.jwtService.signAsync(jwtPayload, {
        secret: this.config.get<string>('AT_SECRET'),
        expiresIn: '15m',
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















  async signToken(userId:number,email:string):Promise<string>{
    const payload={
      sub:userId,
      email
    }
    const secret=this.config.get('JWT_SECRET')
    
    return await this.jwtService.signAsync(payload,{
      expiresIn:'15m',
      secret:secret
    });
  }

  async signup(dto: CreateAuthDto): Promise<Tokens> {
    const hash=await argon2.hash(dto.password)
    try {
      const user = await this.prisma.user.create({
        data: {
          firstName: dto.firstName,
          lastName: dto.lastName,
          email: dto.email,
          hash
        },
      });


      const tokens = await this.getTokens(user.id, user.email);
      await this.updateRtHash(user.id, tokens.refresh_token);
  
      return tokens;

    } catch (error) {
      if (error.code === "P2002"&& error.meta?.target?.includes("email")) {
        throw new ForbiddenException("Email is already taken");
      }
     
    }
    
  }

  async signin(dto:CreateAuthDto): Promise<Tokens>  {
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




    const tokens = await this.getTokens(user.id, user.email);
    await this.updateRtHash(user.id, tokens.refresh_token);

    return tokens;
    
  }

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



  // async deleteAccount(
  //   authorId: number,
  //   // lesserId: number,
  // ):Promise<any> {
  //   const costumer =
  //     await this.prisma.costumers.findUnique({
  //       where: {
  //        id:authorId,
  //       },
  //     });

  

  //   await this.prisma.costumers.delete({
  //     where: {
       
  //       id: authorId,
  //     },
      
  //   });
  // }















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
  
}
