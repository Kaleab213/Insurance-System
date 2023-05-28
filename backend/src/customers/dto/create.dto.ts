/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsString } from "class-validator";

/* eslint-disable prettier/prettier */
export class CreateCustomer{
  @IsNotEmpty()
 
  phone:string;

  @IsNotEmpty()
  
  account_no:string;
}