import { Role } from './role.model';

export class AuthData {
  constructor(
    public userId: number,
    public userName: string,
    private _token: string,
    public loginDate: Date,
    private _tokenExpirationDate: Date
  ) {}

  get token() {
    if (!this._tokenExpirationDate || new Date() > this._tokenExpirationDate) {
      return null;
    }
    return this._token;
  }

}
