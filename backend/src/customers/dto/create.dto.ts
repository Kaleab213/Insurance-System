/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsString } from "class-validator";

/* eslint-disable prettier/prettier */
export class CreateCustomer{
  @IsNotEmpty()
  @IsString()
  phone:string;

  @IsNotEmpty()
  @IsString()
  account_no:string;
}