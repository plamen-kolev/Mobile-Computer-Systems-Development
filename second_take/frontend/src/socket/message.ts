export class Message {
  constructor(public room, public sender, public recipient, public body, public date = ''){}
}
