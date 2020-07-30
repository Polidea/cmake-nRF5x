
#include "pb_encode.h"
#include "pb_decode.h"

int main()
{
  uint8_t buffer[64];
  pb_ostream_t ostream;
  pb_istream_t istream;
  pb_field_t fields[2];

  ostream = pb_ostream_from_buffer(buffer, sizeof(buffer));
  istream = pb_istream_from_buffer(buffer, 2);

  pb_encode(&ostream, fields, NULL);
  pb_decode(&istream, fields, NULL);

  return 0;
}
