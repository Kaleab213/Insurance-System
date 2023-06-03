/* eslint-disable prettier/prettier */
import { IsEmail, IsNotEmpty, IsOptional, IsString } from "class-validator";

/* eslint-disable prettier/prettier */
export class updateAuthDto{
 @IsString()
 @IsOptional()
  firstName: string;
  
  @IsString()
  @IsOptional()
  lastName: string;

  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  password: string;
  
  
}


