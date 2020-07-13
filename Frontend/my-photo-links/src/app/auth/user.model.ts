import { Tag } from "./tag.model";
import { Role } from "./role.model";

export class User {
  constructor(
    public userId: number,
    public firstName: string,
    public lastName: string,
    public email: string,
    public blockFlag: string,
    public blockReason: string,
    private _token: string,
    public loginDate: Date,
    private _tokenExpirationDate: Date,
    public roles: Role[],
    public tags: Tag[]
  ) {}

  get token() {
    if (!this._tokenExpirationDate || new Date() > this._tokenExpirationDate) {
      return null;
    }
    return this._token;
  }

}
