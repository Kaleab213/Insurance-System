/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put, UseGuards } from "@nestjs/common";
import { RequestService } from "./request.service";
import { createDto } from "src/notification/dto/notification.create.dto";
import { updateDto } from "src/notification/dto";
import { CreateAuthDto } from "src/Authentication/dto";
import { Roles, } from "src/decorators/role.auths";
import { AtGuards } from "src/Authentication/gaurds/at.guards";
import { RolesGuard } from "src/Authentication/gaurds/role.gaurd";
import { Role } from "src/decorators/role.enum";

@Controller("request")
export class RequestController {
    constructor(private requestservice: RequestService) {}

    
    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Get()
    get_requests() {
            return this.requestservice.get_requests();
        }


    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Get(":request_id")
    get_requestsby_Id(@Param('request_id',ParseIntPipe) request_id:number) {
        return this.requestservice.get_requestsby_id(request_id);
    }

    @Roles(Role.CUSTOMER)
    @UseGuards(AtGuards, RolesGuard)
    @Post()
    send_request(@Body() dto: createDto) {
        return this.requestservice.send_requests(dto)
    }


    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Put("request_id:approval")
    update_request(@Param('request_id',ParseIntPipe) request_id:number, @Body() dto: updateDto) {
        return this.requestservice.update_request(request_id, dto)
    }

    @Delete(":request_id")
    delete_request(@Param('request_id',ParseIntPipe) request_id:number) {
        return this.requestservice.delete_request(request_id)
    }
 }