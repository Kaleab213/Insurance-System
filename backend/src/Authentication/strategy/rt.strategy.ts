/* eslint-disable prettier/prettier */
import { PassportStrategy } from '@nestjs/passport';
import { ForbiddenException, Injectable } from "@nestjs/common";
import { ExtractJwt, Strategy } from 'passport-jwt';

import { Request } from 'express';
import { JwtPayload, JwtPayloadWithRt } from '../types';


@Injectable()
export class RtStrategy extends PassportStrategy(Strategy, 'jwt-refresh') {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: 'rt-secret',
      passReqToCallback: true,
    });
  }

  validate(req: Request, payload: JwtPayload): JwtPayloadWithRt {
    const refreshToken = req.get('authorization').replace('Bearer', '').trim();
     

    if (!refreshToken) throw new ForbiddenException('Refresh token malformed');

    return {
      ...payload,
      refreshToken,
    };
  }
}