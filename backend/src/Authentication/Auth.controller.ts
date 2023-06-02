/* eslint-disable prettier/prettier */
/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, HttpCode, HttpStatus, Param, ParseIntPipe, Post, Req, UseGuards} from '@nestjs/common';
import { AuthService } from './Auth.service';
import { CreateAuthDto } from './dto';
import { GetUser, GetUserId } from 'src/decorators';

import {  AtGuards } from './gaurds/at.guards';
import { RolesGuard } from './gaurds/role.gaurd';
import { CreateCustomer } from 'src/customers/dto/create.dto';

@Controller('user')
export class AuthController{
  constructor(private authService:AuthService){}

  
  @Post('admin/signup')
  signup(@Body() dto:CreateAuthDto){
    return this.authService.adminsignup(dto);
  }

  @Post('customer/signup')
  Customersignup(@Body() dtouser:CreateAuthDto,@Body() dtocustomer:CreateCustomer){
    return this.authService.CustomerSignup(dtouser,dtocustomer);
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



@UseGuards(AtGuards, RolesGuard)
@Get()
getProfile(@GetUser() userId: number){
  return this.authService.getProfile(userId['id']);
}


  
  @UseGuards(AtGuards, RolesGuard)
  @Delete('deleted')
  deletedAccount(@GetUserId() userId: number){
    console.log(userId);
    
    return this.authService.deleteAccount(userId);
  }
}