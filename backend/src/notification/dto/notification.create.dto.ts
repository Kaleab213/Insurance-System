/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsString } from "class-validator"

export class createDto {
    
    @IsString()
    title:string

    
    @IsString()
    description:string

    
    status:boolean

}