/* eslint-disable prettier/prettier */
/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Req} from '@nestjs/common';
import { AuthService } from './Auth.service';
import { CreateAuthDto } from './dto';

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
  logout(@Body() dto:CreateAuthDto){
    console.log(dto);
    return this.authService.logout();
  }

  @Delete('deleted')
  deletedAccount(@Param() id:number){
    return this.authService.deletedAccount(id);
  }
}