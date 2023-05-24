
import { IsNotEmpty, IsString } from "class-validator"

export class createDto {
    @IsNotEmpty()
    @IsString()
    bill:string

    @IsNotEmpty()
    @IsString()
    ammount:string



}
