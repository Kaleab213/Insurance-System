/* eslint-disable prettier/prettier */
import { IsBoolean, IsOptional } from "class-validator"

export class updateDto {
    
    
    @IsBoolean()
    @IsOptional()
    status?:boolean

}