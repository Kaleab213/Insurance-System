import { IsNotEmpty, IsOptional, IsString, IsNumber } from "class-validator";


/* eslint-disable prettier/prettier */
export class CreateInsuranceDto{
  @IsNumber()
  @IsNotEmpty()
  ammount_money:number; 
  @IsString()
  @IsOptional()    
  telebirr?:string; 

  @IsNumber()  
  @IsNotEmpty()      
  coverage_percentage:number; 
  @IsNotEmpty()
  @IsNumber()  
  deposit:number;  
  @IsNotEmpty() 
  @IsString()        
  type:string;
}