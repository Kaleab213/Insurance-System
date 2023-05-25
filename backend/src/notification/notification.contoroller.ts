import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put, UseGuards } from "@nestjs/common";
import { NotificationService } from "./notification.service";
import { createDto, updateDto } from "./dto";
import { Roles } from "src/decorators/role.auths";
import { Role } from "src/decorators/role.enum";
import { AtGuards } from "src/Authentication/gaurds/at.guards";
import { RolesGuard } from "src/Authentication/gaurds/role.gaurd";
import { GetUser } from "src/decorators";



@Controller("notification")
export class NotificationController {
    constructor(private notificationservice: NotificationService) {}
    @Roles(Role.CUSTOMER)
    @UseGuards(AtGuards, RolesGuard)
    @Get()
    get_notification(@GetUser() userId:number) {
        return this.notificationservice.get_notifications(userId)
    }

    @Roles(Role.CUSTOMER)
    @UseGuards(AtGuards, RolesGuard)
    @Get(":notification_id")
    get_notification_byid(@GetUser() userId:number, @Param('notification_id',ParseIntPipe) notification_id:number) {
        return this.notificationservice.get_notifications_byid(userId, notification_id)
    }

    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Post()
    send_notification(@Body() dto: createDto) {
        return this.notificationservice.send_notification(dto)
    }

    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Put()
    update_notification(@Body() dto: updateDto) {
        return this.notificationservice.update_notification(dto)
    }

    @Roles(Role.ADMIN)
    @UseGuards(AtGuards, RolesGuard)
    @Delete()
    delete_notification(userId) {
        return this.notificationservice.delete_notification(userId)
    }
}