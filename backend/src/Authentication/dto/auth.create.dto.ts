/* eslint-disable prettier/prettier */
import { IsEmail, IsNotEmpty, IsString } from "class-validator";

/* eslint-disable prettier/prettier */
export class CreateAuthDto{
 @IsString()
  firstName: string;
  @IsString()
  lastName: string;
  @IsEmail()
  @IsNotEmpty()
  email: string;
  @IsString()
  @IsNotEmpty()
  password: string;
  id: any;
  
}

