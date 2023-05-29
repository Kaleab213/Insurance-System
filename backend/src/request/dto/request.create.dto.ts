/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsNumber, IsOptional, IsString } from "class-validator"

export class createDto {
    

    @IsNotEmpty()
    @IsString()
    description:string

    @IsOptional()
    status:boolean
    @IsNumber()
    @IsOptional()
    loss?:number

    @IsNumber()
    @IsOptional()
    insured_payment:number

}

export class CreateRequestPhotoDto{

   
    
    police_report:string

    
    supported_document:string
}

