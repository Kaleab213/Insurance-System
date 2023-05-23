/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsOptional, IsString, IsNumber } from "class-validator";


/* eslint-disable prettier/prettier */
export class UpdateInsuranceDto{
  @IsNumber()
  @IsOptional() 
  ammount_money?:number; 
  @IsString()
  @IsOptional()    
  telebirr?:string; 

  @IsNumber()  
  @IsOptional()       
  coverage_percentage?:number; 
  @IsOptional() 
  @IsNumber()  
  deposit?:number;  
  @IsOptional()  
  @IsString()        
  type?:string;
}