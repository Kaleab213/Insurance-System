/* eslint-disable prettier/prettier */
import { JwtPayload } from "./jwtpayload.types";


export type JwtPayloadWithRt = JwtPayload & { refreshToken: string };