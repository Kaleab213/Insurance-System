/* eslint-disable prettier/prettier */
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";

import { Injectable } from "@nestjs/common";
import { JwtPayload } from "../types";

@Injectable()
export class AtStrategy extends PassportStrategy(Strategy, "jwt") {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: "at-secret",
    });
  }

  validate(payload: JwtPayload) {
    console.log(payload);
    return payload;
  }
}
