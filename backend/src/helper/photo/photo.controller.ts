/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable prettier/prettier */

import { Controller, Get, Param, ParseFilePipe, Res } from '@nestjs/common';

import { of } from "rxjs";
import { Response } from 'express';

@Controller("photo")
export class PhotoController {


  @Get(":image")
  GetImage(@Param("image", ParseFilePipe) image: string, @Res() res: Response): any {
    return of(res.sendFile(image, { root: './photos' }));
  }
}
