/* eslint-disable prettier/prettier */


import { diskStorage } from "multer";





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
