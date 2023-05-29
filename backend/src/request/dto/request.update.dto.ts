import { IsBoolean, IsNumber, IsOptional } from "class-validator"

/* eslint-disable prettier/prettier */
export class updateDto {
    @IsBoolean()
    @IsOptional()
    status:boolean
    @IsNumber()
    @IsOptional()
    loss:number}