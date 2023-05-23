/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Post, Put } from "@nestjs/common";
import { RequestService } from "./request.service";
import { createDto } from "src/notification/dto/notification.create.dto";
import { updateDto } from "src/notification/dto";
import { CreateAuthDto } from "src/Authentication/dto";

@Controller("request")
export class RequestController {
    constructor(private requestservice: RequestService) {}

    
// @Get()
//     get_requests(dto:CreateAuthDto) {
//         return this.requestservice.generate_request();
//     }
    @Post()
    send_request(@Body() dto: createDto) {
        return this.requestservice.send_requests(dto)
    }

    @Put()
    update_request(@Body() dto: updateDto) {
        return this.requestservice.update_request(dto)
    }

    @Delete()
    delete_request(userId) {
        return this.requestservice.delete_request(userId)
    }
 }