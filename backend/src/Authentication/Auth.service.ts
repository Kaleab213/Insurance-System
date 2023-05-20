/* eslint-disable prettier/prettier */
import { ConflictException, ForbiddenException, Injectable } from "@nestjs/common";
import { PrismaService } from "src/Prisma/prisma.service";
import { CreateAuthDto } from "./dto";
import * as argon2 from "argon2";

@Injectable()
export class AuthService {
  constructor(private prisma: PrismaService) {}

  async signup(dto: CreateAuthDto) {
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
      return user;
    } catch (error) {
      if (error.code === "P2002"&& error.meta?.target?.includes("email")) {
        throw new ForbiddenException("Email is already taken");
      }
     
    }
  }

  async signin(dto:CreateAuthDto) {
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
    delete user.hash
    return user;
  }

  logout() {
    return { logout: "Logout Successfully" };
  }

  async deletedAccount(userId: number) {
    await this.prisma.user.delete({
      where: {
        id: userId,
      },
    });
    return "Deleted Your Account";
  }
}
