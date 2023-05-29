/* eslint-disable prettier/prettier */

import { IsNotEmpty, IsNumber, IsString } from "class-validator"

export class createDto {
    

  
    @IsNotEmpty()
    ammount:number



}

export class createPhotoDto { 
   
    bill: string
}

