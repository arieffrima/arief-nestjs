import { Injectable } from '@nestjs/common';

@Injectable()
export class UsersService {
  getAllUsers(): string {
    return 'List of users';
  }
}
