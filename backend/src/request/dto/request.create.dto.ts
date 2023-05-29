import { IsNotEmpty, IsOptional, IsString } from "class-validator"

export class createDto {
    

    @IsNotEmpty()
    @IsString()
    description:string

    @IsOptional()
    status:boolean

    @IsOptional()
    loss?:number

    @IsOptional()
    insured_payment:number

}

export class CreateRequestPhotoDto{

   
    @IsNotEmpty()
    @IsString()
    police_report:string

    @IsNotEmpty()
    @IsString()
    supported_document:string
}

