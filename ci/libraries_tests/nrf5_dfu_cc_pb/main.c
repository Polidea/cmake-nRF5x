
#include "pb_encode.h"
#include "pb_decode.h"
#include "dfu-cc.pb.h"

int main()
{
  dfu_init_command_t msg;
  uint8_t buffer[64];
  pb_ostream_t ostream;
  pb_istream_t istream;

  ostream = pb_ostream_from_buffer(buffer, sizeof(buffer));
  istream = pb_istream_from_buffer(buffer, 2);

  pb_encode(&ostream, dfu_init_command_fields, &msg);
  pb_decode(&istream, dfu_init_command_fields, &msg);

  return 0;
}
