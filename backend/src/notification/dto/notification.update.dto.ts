import { IsOptional } from "class-validator"

export class updateDto {
    
    @IsOptional()
    title?:string

    @IsOptional()
    description:string

    @IsOptional()
    status:boolean

}