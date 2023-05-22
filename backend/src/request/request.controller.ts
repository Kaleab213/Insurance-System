import { Body, Controller, Delete, Get, Post, Put } from "@nestjs/common";
import { RequestService } from "./request.service";

@Controller("request")
export class RequestController {
    constructor(private requestservice: RequestService) {}

    @Get()
    get_requests() {
        return this.requestservice.get_requests()
    }

    @Post()
    send_request(@Body() dto: createDto) {
        return this.requestservice.send_request(dto)
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