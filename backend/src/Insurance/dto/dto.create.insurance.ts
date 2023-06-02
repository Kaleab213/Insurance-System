import { IsNotEmpty, IsOptional, IsString, IsNumber } from "class-validator";


/* eslint-disable prettier/prettier */
export class CreateInsuranceDto{
 
  @IsString()
  @IsOptional()    
  telebirr?:string; 

  @IsString()  
  @IsNotEmpty()      
  level:string; 
  @IsOptional()
   
  deposit?:number;  
  @IsNotEmpty() 
  @IsString()        
  type:string;

  @IsNotEmpty() 
  room:number
  @IsString()  
  @IsNotEmpty() 
  location:string
   
  @IsNotEmpty() 
  size:number
  
   
  @IsOptional() 
  
  monthly_payment:number
}
export class CreateInsurancePhotoDto{
  @IsOptional() 
   
  Document:string
}