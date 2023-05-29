/* eslint-disable @typescript-eslint/no-var-requires */
/* eslint-disable prettier/prettier */
import { diskStorage } from "multer";
import {v4 as uuidv4 } from "uuid";
const fs =require("fs");
// const FileType=require('file-type');
import path = require("path");

type ValidFileExtension = 'png'|'gif'|'jpg'|'jpeg';
type ValidMimeType = 'image/png'|'image/gif'|'image/jpg'|'image/jpeg';

const ValidFileExtensions:ValidFileExtension[]=['png','gif','jpg','jpeg']
const ValidmimeTypes:ValidMimeType[]=['image/png','image/gif','image/jpg','image/jpeg']

export const ImageStorage={
    
        storage:diskStorage({
          destination:'./photos',
          filename:(req,file,cb)=>{
            const filename=file.originalname.split('.')[0];
            const fileExtension=file.originalname.split('.')[1];
            const newFilename=filename.split(' ').join('_')+'_'+Date.now()+'.'+fileExtension;
            cb(null,newFilename);
          },}),

      fileFilter:(req,file,cb)=>{
        if (!file.originalname.match(/\.(jpg|png|gif|jpeg)$/)){
          cb(null,false);
        }
        cb(null,true);
    
      }
    }
