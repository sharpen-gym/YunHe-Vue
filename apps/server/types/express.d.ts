declare namespace Express {
  interface Request {
    user: AuthType.JwtPayload
  }
}
