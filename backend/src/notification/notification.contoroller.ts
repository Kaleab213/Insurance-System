import { Body, Controller, Delete, Get, Post, Put } from "@nestjs/common";
import { NotificationService } from "./notification.service";
import { createDto, updateDto } from "./dto";



@Controller("notification")
export class NotificationController {
    constructor(private notificationservice: NotificationService) {}

    @Get()
    get_notification() {
        return this.notificationservice.get_notifications()
    }

    @Post()
    send_notification(@Body() dto: createDto) {
        return this.notificationservice.send_notification(dto)
    }

    @Put()
    update_notification(@Body() dto: updateDto) {
        return this.notificationservice.update_notification(dto)
    }

    @Delete()
    delete_notification(userId) {
        return this.notificationservice.delete_notification(userId)
    }
}