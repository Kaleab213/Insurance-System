/* eslint-disable prettier/prettier */

import { IsBoolean, IsNotEmpty, IsOptional, IsString } from "class-validator"

export class updateDto {
   @IsBoolean()
   @IsOptional()
   status?:boolean
   

}
