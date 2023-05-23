/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsString } from "class-validator"

export class createDto {
    @IsNotEmpty()
    @IsString()
    title:string

    @IsNotEmpty()
    @IsString()
    description:string

    
    status:boolean

}