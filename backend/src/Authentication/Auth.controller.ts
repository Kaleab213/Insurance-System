/* eslint-disable prettier/prettier */
/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, HttpCode, HttpStatus, Param, ParseIntPipe, Post, Req, UseGuards} from '@nestjs/common';
import { AuthService } from './Auth.service';
import { CreateAuthDto } from './dto';
import { GetUser, GetUserId } from 'src/decorators';
import { Role } from 'src/decorators/role.enum';
import { Roles } from 'src/decorators/role.auths';
import {  AtGuards } from './gaurds/at.guards';
import { RolesGuard } from './gaurds/role.gaurd';

@Controller('auth')
export class AuthController{
  constructor(private authService:AuthService){}
  @Post('signup')
  signup(@Body() dto:CreateAuthDto){
    return this.authService.signup(dto);
  }

  @Post('signin')
  signin(@Body() dto:CreateAuthDto){

    
    return this.authService.signin(dto);
  }

  @Post('logout')
  @HttpCode(HttpStatus.OK)
  logout(@GetUser() userId: number): Promise<boolean> {
    return this.authService.logout(userId);
  }
  // @Roles(Role.CUSTOMER)
  @UseGuards(AtGuards, RolesGuard)
  @Delete('deleted')
  deletedAccount(@GetUserId() userId: number){
    console.log(userId);
    
    return this.authService.deleteAccount(userId);
  }
}