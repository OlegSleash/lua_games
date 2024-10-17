local imgui, encoding = require 'mimgui', require 'encoding'
local new = imgui.new
encoding.default = 'CP1251'
u8 = encoding.UTF8
local data = {
   stage_cell = {},
   state_cell = {},
   temp_cells = {},
   game_step = 1,
   square_lot = {x = 9, y = 9},
   bombs = 10,
   true_flags = 0,
   all_flags = 0,
   start_time = 0,
   end_time = 0,
   square_lot_imgui = {x = new.int(9), y = new.int(9)},
   bombs_imgui = new.int(10),
   ValidAnim = new.bool(false),
   images = {
        flag_data = "\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x00\x32\x00\x00\x00\x32\x08\x06\x00\x00\x00\x1E\x3F\x88\xB1\x00\x00\x00\x09\x70\x48\x59\x73\x00\x00\x0B\x13\x00\x00\x0B\x13\x01\x00\x9A\x9C\x18\x00\x00\x00\xFB\x49\x44\x41\x54\x78\x9C\xED\xD8\xBD\x4D\xC4\x40\x10\x06\xD0\x11\x44\x48\x04\x24\x14\x40\x03\x54\x41\x42\x01\xB4\x40\x4A\x78\x29\x21\x2D\xD0\x02\x2D\xD0\x82\xF3\x6B\xC0\x01\x97\x5E\x76\x81\xF5\x08\x90\xA5\x4B\x90\xF8\x39\xDB\x33\xD6\xBE\x0E\x46\xDF\xFA\xF3\xEE\x44\xFC\x00\xEE\x71\x16\xD5\xF9\xD2\xE3\x19\xD7\x51\x7C\x90\xD1\x01\x6F\xB8\x8B\x6A\x7C\x6F\x8B\x27\x5C\x46\xF1\x41\x46\x7B\xBC\xE2\x36\x32\xF3\x3B\x1D\x1E\x71\x11\xC5\x07\x19\xED\xF0\x82\x9B\xC8\xC2\xFF\x0C\x78\xC7\x03\xCE\x2B\x0F\x72\x6C\xD9\x0A\x77\x7A\xCB\x54\xB8\x69\xCD\x57\xE1\xE6\x31\x7D\x85\x9B\x5F\x37\x49\x85\x5B\xCE\xEE\xA4\x15\x6E\x79\xC3\x49\x2A\x5C\x2E\xFD\x9F\x2B\x5C\x2E\x7D\xE5\x41\x86\xEA\x47\xEB\xA3\xFA\xC7\xDE\x55\xAE\xDF\xF2\x3F\xC4\xD2\x57\x94\x43\xF5\x4B\x63\x5F\xF9\x1A\x3F\x54\x7F\x58\xED\xAA\x3F\x75\xBB\xCA\xCB\x87\x7D\xF5\x75\xD0\x16\x1B\x5C\x45\x05\x56\xB8\x32\xDD\xAC\x62\x89\x1D\xD5\x69\x83\x24\xA3\x25\x92\x8C\x96\x48\x32\x5A\x22\xC9\x68\x89\x24\xA3\x25\x92\x8C\x96\x48\x32\x5A\x22\xC9\x58\x4B\x22\x51\xC0\x27\x81\x66\x37\x01\xF0\x60\xDD\x97\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82",
        flag = nil,
        mine_data = "\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x00\x19\x00\x00\x00\x19\x08\x06\x00\x00\x00\xC4\xE9\x85\x63\x00\x00\x00\x09\x70\x48\x59\x73\x00\x00\x0B\x13\x00\x00\x0B\x13\x01\x00\x9A\x9C\x18\x00\x00\x00\xEF\x49\x44\x41\x54\x78\x9C\xED\x95\x4D\x0A\xC2\x30\x10\x85\x7B\x0C\x71\x59\xE8\x65\xBA\x2A\xFD\xC1\x93\x48\x6F\x20\x5E\x44\x8F\x60\x6D\xBD\x4F\xAB\x1E\x41\xA1\x9F\x04\x22\x94\x90\xA4\x31\xA9\xBB\x3E\x28\x21\x99\xCC\x3C\xDE\x34\x33\x13\x45\x2B\x96\x04\xB0\x03\x62\x83\x2D\x06\xCA\x25\x48\xB6\x40\x03\x74\xC0\x00\xBC\xE5\x2A\xF6\x17\x61\x0F\x25\xA8\x80\x1E\x3B\x7A\x6F\x35\x40\x0D\x8C\x9A\xA0\x27\xCD\x99\xB8\x57\xFB\x28\xD0\x11\x08\x9C\xD1\x63\x74\x52\x04\x64\xC0\x46\xE6\xDC\x07\xBD\xF4\xCF\x6C\x24\x09\x70\x55\x1C\xD3\x99\xC0\xA9\xB2\x17\xFE\xC9\x9C\x9A\x1B\x61\xE8\x5C\x52\xF6\x0C\x24\xB9\xBB\x90\x1C\x80\x63\xC0\x77\x70\x21\x79\x04\x2A\x19\x5C\x48\xFE\xFB\x4F\xD0\xBF\x2E\x5D\xF1\xD9\xEC\x8D\xF5\x75\x01\x85\xA6\x4E\x4C\xC5\xA7\xB3\x7F\xEB\xA4\x70\x49\x59\x69\xA9\x78\x13\xC4\xFD\x7C\x36\xB8\x63\xEF\x4A\x0D\x04\xFB\x9F\x08\x14\x45\x2E\x5D\x38\xF7\x22\x50\xE6\x89\x98\x1B\xAD\x0C\xF8\x92\x6B\xBB\xC8\x3C\x99\x74\x64\xDB\x64\xAC\x82\x49\x56\x44\x13\x7C\x00\x22\x1A\xF3\x07\x46\x16\x08\x1D\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82",
        mine = nil,
        reset_data = "\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x00\x40\x00\x00\x00\x40\x08\x06\x00\x00\x00\xAA\x69\x71\xDE\x00\x00\x00\x09\x70\x48\x59\x73\x00\x00\x0B\x13\x00\x00\x0B\x13\x01\x00\x9A\x9C\x18\x00\x00\x03\x59\x49\x44\x41\x54\x78\x9C\xED\x9A\x4B\x6C\x4D\x41\x18\xC7\xA7\x8A\x6A\x51\x51\xBB\x36\x62\x61\xD5\xA8\x8D\xC4\x92\xAA\x56\xDA\xA8\xE0\x2E\xAC\xEC\x48\x2C\x3C\x12\x22\xAC\x3C\x13\x41\x89\x12\x92\xB6\x92\x8A\xC4\xAB\x09\x12\x0B\x12\x5B\xB6\x42\xE2\x91\x68\x17\x1E\x0B\xD7\xAB\x8A\x48\xC4\xB3\xF5\x93\x71\x47\x68\xF5\xCC\x9C\x7B\xEE\xCC\x39\xA7\xD7\xFC\x92\xB3\xB9\xF7\xDC\xF9\x7F\xDF\xCC\xDC\x99\x6F\xBE\xF9\x84\xF0\x78\x3C\x1E\x8F\xC7\xE3\x19\x03\x00\x9B\x81\x3E\xE0\x3A\x50\x2D\xFE\x27\x80\xD5\x0C\xE7\xBC\x18\x8B\x00\xA5\xC0\x2C\xA0\x01\x68\x01\x9A\x80\x7A\xA0\x16\x18\x1F\xF0\x9B\xD9\xC0\x87\x11\x1D\xF0\x11\xA8\x10\x69\x07\x28\x03\x32\x40\x17\xF0\x10\xF8\x4A\x30\x5F\x80\xDB\xEA\xDD\xC5\xAA\xB3\x26\x02\xB7\x02\xDE\xCF\x88\xB4\x02\xCC\x04\x8E\x01\xEF\x88\xCE\x0B\xE0\xA6\xE6\xFB\xB3\x22\x6D\x00\x95\x40\xBB\x61\xA4\x6D\xF1\x1E\x98\x20\xD2\x02\xD0\x08\x64\x89\x97\x66\x91\x06\x80\x1D\xC0\x10\xF1\xD3\x95\xB4\xE3\xE3\x80\x93\x24\xC7\x2B\x69\x43\x52\xCE\x97\x00\x9D\x11\x8C\x1E\x04\x9E\xAA\x15\x5F\x3E\xCF\xD4\x67\x51\x59\x90\x54\x07\x6C\xCB\xC3\x48\xE9\xE4\x71\xB5\x4E\x94\x8D\xD2\x56\x39\xB0\x1C\xF8\x1E\xA1\x03\xDA\x93\x70\xBE\x3E\xE4\xA8\xF5\x03\x1B\xC3\xAC\xD6\x40\x0F\xD1\x90\xB3\xA9\x24\x1E\xCF\xC5\x2F\x43\xA7\x00\x4F\x42\x18\x76\x59\x6E\x8B\x21\xDB\x5C\x43\x61\xCC\x73\xEF\xB9\x02\xD8\x6F\x30\xE6\x07\xB0\x37\xEC\xA8\xA8\xD0\x58\x86\xB6\x85\xB0\x4F\xC4\x01\x50\x0D\x7C\xB2\x69\x8C\x85\xD1\x97\x5C\x73\xE7\xF5\x5F\x00\x07\x0C\x86\x5C\xC9\x77\x5B\x02\xEA\x2C\x44\x8E\x3B\x85\x6B\xC8\x1D\x4C\x06\x34\x46\xC8\xB8\xBF\x2A\x62\xDB\xCD\xC0\x39\xE0\x62\x9E\x4F\x8F\xCA\x13\x94\xDA\xF7\x78\x04\x40\xAB\x61\x14\xB6\x88\x62\x86\xDC\x31\x35\x88\xD7\x72\x86\x88\x62\x86\xDC\x79\x3E\x88\x4E\x51\xCC\x00\x15\x6A\x7B\x0B\xA2\x51\x14\x33\xC0\x5C\xC3\xFF\xBF\x32\x01\x9B\x26\x03\x5B\x81\xAB\x32\x39\x22\xB3\x48\x2E\xC5\x96\x68\x9C\x1F\x70\x26\xAC\x8F\x46\xEF\x8D\xB0\x43\xCE\xD0\x4D\xAE\x04\x33\x9A\x0E\xB8\xEB\x44\x54\x6F\xCF\xEE\x00\x5B\x3E\x03\x33\x5C\x08\xAE\xD4\x74\x40\x9F\x75\x41\xB3\x3D\x37\x34\xF6\xB4\xB8\x10\x6C\xD2\x08\xF6\x5B\x17\x34\xDB\xF3\x32\xD6\x05\x19\x98\xA3\x11\x1C\x8C\x33\x47\xAF\x16\x3F\xDD\x8E\x54\xE7\x42\x74\x92\x21\xE7\x67\x7F\xDA\x05\xDB\xB2\xC8\x30\x18\xE5\xAE\x84\x7B\xD3\x90\x95\x51\xF7\x0D\x41\xF4\xBA\x14\xEE\x30\xA4\xBC\xFE\x49\x75\x39\x3A\x90\x49\xAD\x20\x3A\x5C\x8A\xAF\x40\xCF\x06\x67\xE2\x7F\x6C\x58\x6F\xB0\x61\x59\x92\xC7\xE1\x2C\x30\xD5\xA1\xFE\x34\xE0\xB9\x46\x7F\xC0\xF9\x81\x0C\x38\x6A\x18\x81\x4B\xAE\x12\x94\xAA\x6D\x1D\x87\x5C\xE8\x0E\x03\xA8\x51\xB7\xB8\x3A\xB6\x0B\xCB\xC8\x36\x0D\x9A\x32\x02\xAC\xB1\xAD\x1B\x75\x16\xC8\x3D\x7A\x8F\xAD\x99\x20\xD3\x5D\x98\x69\xB3\xA1\x95\xCF\x0D\xB0\x6E\x25\xFE\xCD\x19\x60\x7A\x01\x3A\x55\xC0\x85\x10\x3A\x8F\x63\x3F\x8D\x92\xAB\xEE\x08\x73\x19\xFA\x06\x58\x17\x54\xFD\xA1\x09\xBA\xD6\xAA\xFA\x00\x13\x32\x99\x3A\xDF\xAD\xB7\xF9\x9F\xC8\x82\x52\x66\x27\x80\x85\x72\x35\x0F\x08\x6F\x65\x62\xB4\x4D\xBD\x1B\x96\xE4\xF2\x90\xE4\x2E\x47\x4F\x11\x0D\x79\x65\x76\x07\x78\xA4\x1C\xFE\x16\xA1\x8D\xEE\x58\xAF\xC4\x46\x43\xD5\xF1\x9C\x26\x7E\xBA\x13\xBB\x16\x0F\x98\x09\xBB\x0C\x27\x34\x5B\x0C\xC5\x72\x09\x52\x40\xCE\x20\xCC\xEE\x10\x95\x6C\xEA\x93\xAF\xE4\xC2\xD5\x36\x15\x98\xD8\x42\xB6\x75\xC4\x65\x98\xED\xAA\x4C\xEE\x20\xF0\xB6\x00\xC7\xE5\x16\x7A\x38\xB6\x08\xCF\x61\xA1\xE4\x52\x55\x47\x74\xDF\x50\x54\x21\xBF\x7B\xA0\xCA\x6E\x5A\xE3\x38\x5E\xC7\x8E\x2A\x85\xA9\x55\xEB\xC5\x2A\xF5\x34\xA8\xCF\xD2\x5F\xFA\xEA\xF1\x78\x3C\x1E\x8F\xC7\xE3\x11\xC5\xC1\x4F\x26\x8F\xBB\x94\xCC\xDC\x8F\xCA\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82",
        reset = 0,
        settings_data = "\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x00\x32\x00\x00\x00\x32\x08\x06\x00\x00\x00\x1E\x3F\x88\xB1\x00\x00\x00\x09\x70\x48\x59\x73\x00\x00\x0B\x13\x00\x00\x0B\x13\x01\x00\x9A\x9C\x18\x00\x00\x02\xDB\x49\x44\x41\x54\x78\x9C\xED\x9A\xBF\x6B\x14\x41\x14\xC7\x37\xE4\x30\x68\xBC\x13\xC1\x68\xE1\x0F\x84\x04\x34\x11\x31\x46\xD1\x88\xA5\xD8\x68\xAF\x96\x06\xFD\x03\x22\xB1\x8B\x0A\x12\x50\x34\xE8\x5F\xA0\x95\x9D\x41\x2C\x6C\x15\x2C\x34\x62\x11\x6D\x2D\x44\x31\x87\xC2\xC5\x4A\x8B\x24\xDE\x25\xF7\x91\x81\x17\x58\xC6\xCD\xEE\xFC\xCA\xED\x5E\xCC\x17\xAE\xBA\xB7\x6F\xE6\xB3\x3B\x6F\xE6\xED\x7B\x1B\x45\x1B\xFA\x0F\x04\xDC\x03\x96\xF9\x57\x0D\x60\x2C\x6A\x17\x01\x55\x56\xD7\x87\xA8\x1D\x04\x54\x80\x66\x0A\xC8\x22\x50\x8A\x8A\x2E\x60\x98\x6C\x1D\xCC\x73\x82\xFB\x80\x6B\x40\x4F\x86\xDD\x88\x01\xC8\x85\x0C\x1F\x3D\xC0\x28\xB0\x37\x34\xC4\x7E\xE0\xAB\x4C\xA2\x06\x9C\x4F\xB1\x9D\x34\x00\xB9\x9D\x72\xFD\x19\xE0\xBB\xD8\xA9\x58\xEB\x0B\x05\xD1\x97\x10\xBC\x2A\x06\x1E\x00\x5D\x9A\xED\x76\xE0\x8D\x01\xC8\x2B\xA0\xAC\x5D\xBB\x49\x6E\x82\x1E\x5F\xB3\x40\xEF\x5A\x40\xC4\xF5\x11\x18\x90\xB8\x78\x0E\xFC\xC1\x5C\xF3\xC0\x13\xE0\x30\x70\x00\x98\x49\xB1\x75\x87\x01\xF6\x64\x40\xAC\xA8\x8E\x9F\xD4\x13\x58\x30\xB0\x9B\x05\x76\xBB\x80\x98\x04\x6D\xAB\x75\xD9\x05\x64\x0B\xF0\x89\xE2\xE8\x33\xB0\xD5\x1A\x44\x60\x8E\x05\x58\x3A\x21\xD4\x00\x4E\x3A\x41\xC4\x60\x6E\xE5\x4D\x01\xDC\xF0\x82\x10\x90\x12\x30\x9D\x23\xC4\x5B\xA0\xD3\x1B\x24\xB6\x0D\xE7\xB1\xC4\xE6\xBD\xCF\x10\x0D\xE4\x14\xF9\x68\x19\x38\x14\x12\xE4\x85\xE5\x04\x54\x1A\x33\x0E\x0C\x02\xDD\xF2\x3B\xAA\xD6\xBA\xFC\x67\xA3\x47\xA1\x20\x76\xCA\xAE\x61\xAA\xA7\x7A\xFA\xA1\xF9\x2B\x03\x53\x16\xFE\x7E\x01\x9B\x5D\xDF\x27\x54\xCA\x71\x55\xF2\xA9\xF7\x96\x10\x1D\x06\x63\x74\x58\xC2\xBC\x06\xEE\xCB\x21\x7D\x22\xED\x46\x29\xE7\x77\x25\x0D\x70\x55\x2D\x75\x80\xE4\x1B\x36\xE7\x31\xDE\x37\x35\xE7\x24\xC7\x4B\xF8\x69\xDC\x14\x22\x36\xE6\x4D\xCF\x31\x97\x92\x9C\xA6\xBD\x9E\x9A\xE8\x88\x03\x88\xDA\x00\x7C\xD4\x5C\x0B\x10\xEB\x3C\x48\x02\xBF\x70\x20\x65\x07\x90\x4A\x11\x41\x06\x8B\xB2\xB4\xEA\xAD\x4E\xEC\x02\x24\xA4\xF5\x24\xA7\xD7\x55\xF1\x4C\xEA\x4E\xAD\xD8\x7E\xB7\x01\x3F\x1D\xC7\x5A\x94\xB9\x8E\x65\x65\xBB\xEA\x3D\xFC\x22\x70\xC7\xB0\x98\xB0\xA2\x29\x8B\x03\xF1\x99\x85\xDF\x97\xC0\x84\x2A\x23\x01\xFD\x4E\x05\x3E\x87\x14\x45\xC1\x54\x32\x9E\x84\x0D\xC4\x6F\xA7\x14\x25\x50\xD2\x38\x27\x87\xDD\x90\xDA\x96\xE5\x37\x24\x31\x61\xBB\x9C\x1E\x07\x81\xC8\x39\x8D\x6F\x86\x4E\xE3\x07\x2C\x97\x57\x28\x2D\xA8\x9A\x57\x28\x88\x2E\x29\xC4\xE5\xA5\x19\x55\x85\x0C\x01\xF2\x90\xFC\x35\xE9\x0B\x71\x36\xC0\x89\x1F\x42\x4D\xE0\x9C\x2B\xC4\x0E\xE0\x07\xC5\x51\x0D\xD8\xE5\x02\xA2\x7A\x21\x45\xD3\xA8\x6B\x63\xC7\xA4\x88\x6D\x53\x81\xF7\x29\x62\x57\xD5\x9C\xAC\x41\x0C\xDB\x0A\xEF\xC4\x66\x58\x4E\x6B\xD7\xB6\x42\x6F\x46\x11\xB0\xEA\xDD\xF0\x59\x05\xA6\x21\xA7\x74\x29\xA1\xD1\x33\x6D\x58\x4C\xD0\x1B\x3D\x9D\x52\x2E\xD2\xB3\xF0\xA0\x5D\xAB\x78\xEB\xED\x0B\x70\xDA\x73\xBB\x9E\x48\xB9\xFE\x78\xAC\x0B\x10\x0E\x42\x6B\xFC\xA8\x72\x4C\x77\x86\xDD\x15\x03\x90\x4B\x06\x2D\x8D\x11\xA7\xC6\x4E\x8B\xF3\xB2\xFE\xA8\xE8\x62\xBD\x7C\x30\xB0\x6E\x3E\xE1\x88\x55\x2D\xDB\xFF\xA3\x9A\x0D\x45\xEE\xFA\x0B\x20\xF1\xB1\xFC\x26\x36\x23\x46\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82",
        settings = nil,
   },
    ShowMenu        = false,
    MenuAnimWindow  = 0,
    SMenuAnimWindow = 300,
    MenuAnimText    = 0,
    SMenuAnimText   = 300,
    cells_anims = {},
    cs = 0,
    LockWin = false,
    LockHovCell = false
}
function imgui.AddCellAnim(cellid, frames, Ssize, Esize, Ecolor, Efunc)
    data.cells_anims[cellid] = {
        f = frames,
        Ss = (Esize-Ssize)/frames,
        Ec = Ecolor,
        func = Efunc,
        NS = Ssize
    }
end
local WinOpen = new.bool()
local r = 0
function convertime(time)
    local strs = {}
    if time > 3600 then table.insert(strs, math.floor(time/3600)..":") time = time - math.floor(time/3600)*3600 end
    if time > 60 then table.insert(strs, math.floor(time/60)..":") time = time - math.floor(time/60)*60 end
    table.insert(strs, time)
    local str = ''
    for i = #strs, 1 do if str:len() > 0 then str = str..strs[i] else str = strs[i] end end
    return str
end
function random(x, y)
    x = x or 0
    y = y or 0
    math.randomseed(os.time() * math.random(1000, 1000000))
    r = r + tonumber(math.random(1000, 1000000))
    if x == 0 and y == 0 then math.randomseed(r) if (math.random(r) % 2) == 1 then return 1 else return 0 end
    elseif x ~= 0 and y == 0 then math.randomseed(r) return math.random(x)
    else math.randomseed(r) return math.random(x, y) end
end
function normal(cell_id) if cell_id > 0 and cell_id <= data.square_lot.x*data.square_lot.y then return true else return false end end
function StartSapper(cell)
    data.cells_anims = {}
    data.start_time = os.time()
    data.square_lot.x = data.square_lot_imgui.x[0]
    data.square_lot.y = data.square_lot_imgui.y[0]
    data.bombs = data.bombs_imgui[0]
    data.game_step = 1
    data.true_flags = 0
    data.all_flags = 0
    for i = 1, data.square_lot.x*data.square_lot.y do data.stage_cell[i] = 1 end
    for i = 1, data.square_lot.x*data.square_lot.y do data.state_cell[i] = {false, false} end
    for i = 1, data.bombs do
        ::restart_bomb::
        local bmb = random(data.square_lot.x*data.square_lot.y)
        if cell then
            if CellsNear(bmb, cell) then
                goto restart_bomb end end
        if data.state_cell[bmb][2] == true then goto restart_bomb else data.state_cell[bmb][2] = true end
    end
    WinOpen[0] = true
end
function main()
   while not isSampAvailable() do wait(100) end
   sampRegisterChatCommand('sapper', function() if WinOpen[0] == false then StartSapper() else WinOpen[0] = false end end)
   wait(-1)
end
function OpenCell(cell)
   local mines_near = 0
   ::check_cells::
   mines_near = 0
   if data.state_cell[cell][1] == true then goto go_to_end_check end
   data.state_cell[cell][1] = true
   data.stage_cell[cell] = 13
   if ((cell - 1) % data.square_lot.x) ~= 0 then
      if normal(cell-1) then if data.state_cell[cell-1][2] == true then mines_near = mines_near + 1 end end
      if normal(cell+data.square_lot.x-1) then if data.state_cell[cell+data.square_lot.x-1][2] == true then mines_near = mines_near + 1 end end
      if normal(cell-data.square_lot.x-1) then if data.state_cell[cell-data.square_lot.x-1][2] == true then mines_near = mines_near + 1 end end end
   if (cell % data.square_lot.x) ~= 0 then
      if normal(cell+1) then if data.state_cell[cell+1][2] == true then mines_near = mines_near + 1 end end
      if normal(cell-data.square_lot.x+1) then if data.state_cell[cell-data.square_lot.x+1][2] == true then mines_near = mines_near + 1 end end
      if normal(cell+data.square_lot.x+1) then if data.state_cell[cell+data.square_lot.x+1][2] == true then mines_near = mines_near + 1 end end end
   if normal(cell-data.square_lot.x) then if data.state_cell[cell-data.square_lot.x][2] == true then mines_near = mines_near + 1 end end
   if normal(cell+data.square_lot.x) then if data.state_cell[cell+data.square_lot.x][2] == true then mines_near = mines_near + 1 end end
   if mines_near == 0 then
      if ((cell - 1) % data.square_lot.x) ~= 0 then
         if normal(cell-1) then if data.state_cell[cell-1][2] == false and data.stage_cell[cell-1] == 1 then table.insert(data.temp_cells,cell-1) end end
         if normal(cell+data.square_lot.x-1) then if data.state_cell[cell+data.square_lot.x-1][2] == false and data.stage_cell[cell+data.square_lot.x-1] == 1 then table.insert(data.temp_cells,cell+data.square_lot.x-1) end end
         if normal(cell-data.square_lot.x-1) then if data.state_cell[cell-data.square_lot.x-1][2] == false and data.stage_cell[cell-data.square_lot.x-1] == 1 then table.insert(data.temp_cells,cell-data.square_lot.x-1) end end end
      if (cell % data.square_lot.x) ~= 0 then
         if normal(cell+1) then if data.state_cell[cell+1][2] == false and data.stage_cell[cell+1] == 1 then table.insert(data.temp_cells,cell+1) end end
         if normal(cell-data.square_lot.x+1) then if data.state_cell[cell-data.square_lot.x+1][2] == false and data.stage_cell[cell-data.square_lot.x+1] == 1 then table.insert(data.temp_cells,cell-data.square_lot.x+1) end end
         if normal(cell+data.square_lot.x+1) then if data.state_cell[cell+data.square_lot.x+1][2] == false and data.stage_cell[cell+data.square_lot.x+1] == 1 then table.insert(data.temp_cells,cell+data.square_lot.x+1) end end end
      if normal(cell-data.square_lot.x) then if data.state_cell[cell-data.square_lot.x][2] == false and data.state_cell[cell-data.square_lot.x][1] == false and data.stage_cell[cell-data.square_lot.x] == 1 then table.insert(data.temp_cells,cell-data.square_lot.x) end end
      if normal(cell+data.square_lot.x) then if data.state_cell[cell+data.square_lot.x][2] == false and data.state_cell[cell+data.square_lot.x][1] == false and data.stage_cell[cell+data.square_lot.x] == 1 then table.insert(data.temp_cells,cell+data.square_lot.x) end end
   else data.stage_cell[cell] = 4 + mines_near end
   ::go_to_end_check::
   if data.state_cell[cell][2] == true then
        data.game_step = 0;
        data.stage_cell[cell] = 4
        for k, v in pairs(data.state_cell) do
            if v[2] then 
                imgui.AddCellAnim(k, 5, data.cs, data.cs*0.1, 0xFF55CC55, function()
                    data.state_cell[k][1] = true
                    if data.stage_cell[k] < 3 then data.stage_cell[k] = 4 end
                end)
            end
        end
    end
   if #data.temp_cells > 0 then
        local nextCell = data.temp_cells[1]
        table.remove(data.temp_cells, 1)
        if data.state_cell[nextCell][1] then goto go_to_end_check end
        imgui.AddCellAnim(nextCell, 1, data.cs, data.cs*0.1, 0xFF55CC55, function()
            OpenCell(nextCell)
            --goto check_cells
        end)
    end
   return true
end
imgui.OnInitialize(function()
   data.images.flag = imgui.CreateTextureFromFileInMemory(imgui.new('const char*', data.images.flag_data), #data.images.flag_data)
   data.images.mine = imgui.CreateTextureFromFileInMemory(imgui.new('const char*', data.images.mine_data), #data.images.mine_data)
   data.images.reset = imgui.CreateTextureFromFileInMemory(imgui.new('const char*', data.images.reset_data), #data.images.reset_data)
   data.images.settings = imgui.CreateTextureFromFileInMemory(imgui.new('const char*', data.images.settings_data), #data.images.settings_data)
end)
local Win = imgui.OnFrame(
function() return WinOpen[0] end,
function(player)
    if not (imgui.IsMouseDown(0) or imgui.IsMouseDown(1)) then data.LockHovCell = false end
   if imgui.GetFrameCount() == 1 then imgui.SetNextWindowSize(imgui.ImVec2(400, 400)) end
   imgui.Begin('Sapper', WinOpen, imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar + ((data.LockHovCell or imgui.IsMouseDown(1) or data.LockWin) and imgui.WindowFlags.NoMove or 0))
   local cell_size = math.min((imgui.GetWindowSize().x-80)/data.square_lot.x, (imgui.GetWindowSize().y-80)/data.square_lot.y)
    data.cs = cell_size
    local WinSize = imgui.GetWindowSize()
    local cpos = {x = 40, y = 40}
    local WP = imgui.GetWindowPos()
    local dl = imgui.GetWindowDrawList()
    for i = 1, data.square_lot.x*data.square_lot.y do
        imgui.SetCursorPos(cpos)
        if data.stage_cell[i] < 3 then -- 0x AA BB GG RR
            local RectColor = (data.cells_anims[i] ~= nil and data.cells_anims[i].Ec or (data.stage_cell[i] == 2 and 0xFF55CC55 or 0xFF33AA33))
            local RectSize = (data.cells_anims[i] ~= nil and data.cells_anims[i].NS or cell_size)
            local Ro = (cell_size - RectSize)/2
            dl:AddRectFilled({x=Ro+cpos.x+WP.x,y=Ro+cpos.y+WP.y}, {x = Ro+WP.x +cpos.x+RectSize, y = Ro+WP.y +cpos.y+RectSize}, RectColor, 8, GetRoundings(i))
            if imgui.IsPosHovered(cpos, WP, cell_size, i) and data.game_step == 1 then data.stage_cell[i] = 2
                data.LockHovCell = true
            else data.stage_cell[i] = 1 end
            if imgui.IsPosHovered(cpos, WP, cell_size, i) and imgui.IsMouseReleased(1) and data.game_step == 1 then
                if data.all_flags == data.bombs then
                    sampAddChatMessage('{00FF00}[SAPPER]{FFFFFF} У Вас закончились флажки!')
                else
                    data.all_flags = data.all_flags + 1
                    imgui.AddCellAnim(i, 7, cell_size, cell_size*0.8, 0xFF3A3A3A, function()
                        data.stage_cell[i] = 3
                        if data.state_cell[i][2] == true then
                            data.true_flags = data.true_flags + 1
                        end
                        if data.true_flags == data.bombs then
                            data.game_step = 2
                        end
                    end)
                end
            elseif imgui.IsPosHovered(cpos, WP, cell_size, i) and imgui.IsMouseReleased(0) and data.game_step == 1 then
                imgui.AddCellAnim(i, 1, cell_size, cell_size*0.1, 0xFF55CC55, function()
                    if IsAllCellsClosed() then
                        data.square_lot.x = data.square_lot_imgui.x[0]
                        data.square_lot.y = data.square_lot_imgui.y[0]
                        data.bombs = data.bombs_imgui[0]
                        if data.square_lot.x*data.square_lot.y - 9 >= data.bombs then
                            StartSapper(i)
                        end
                    end
                    OpenCell(i)
                end)
            end
        elseif data.stage_cell[i] < 5 then
            local RectColor = (data.cells_anims[i] ~= nil and data.cells_anims[i].Ec or 0xFF3A3A3A)
            local RectSize = (data.cells_anims[i] ~= nil and data.cells_anims[i].NS or cell_size*0.8)
            local Ro = (cell_size - RectSize)/2
            if data.stage_cell[i] == 3 then 
                dl:AddRectFilled({x=Ro+cpos.x+WP.x,y=Ro+cpos.y+WP.y}, {x = Ro+WP.x +cpos.x+RectSize, y = Ro+WP.y +cpos.y+RectSize}, RectColor, 8)
            end
            imgui.SetCursorPos({x=cpos.x+cell_size*0.1,y=cpos.y+cell_size*0.1})
            imgui.Image(data.stage_cell[i] == 3 and data.images.flag or data.images.mine, imgui.ImVec2(cell_size*0.8, cell_size*0.8))
            if imgui.IsItemHovered() then data.LockHovCell = true end
            if imgui.IsMouseReleased(1) and imgui.IsItemHovered() and data.game_step == 1 and data.stage_cell[i] == 3 then
                data.all_flags = data.all_flags - 1
                imgui.AddCellAnim(i, 7, cell_size*0.8, cell_size, 0xFF33AA33, function()
                    if data.stage_cell[i] == 3 then
                        data.stage_cell[i] = 1
                        if data.state_cell[i][2] == true then
                            data.true_flags = data.true_flags - 1
                        end
                    end
                end)
            end
        elseif data.stage_cell[i] < 13 then
            local CalcStage = imgui.CalcTextSize(tostring(data.stage_cell[i]-4))
            if imgui.IsPosHovered(cpos, WP, cell_size) and imgui.IsMouseReleased(0) then
                local nearflags, cellsforopen = GetNearFlags(i)
                if nearflags == data.stage_cell[i]-4 and #cellsforopen > 0 then
                    for _, v in pairs(cellsforopen) do
                        imgui.AddCellAnim(v, 3, cell_size, cell_size*0.1, 0xFF55CC55, function() OpenCell(v) end)
                    end
                end
            end
            imgui.SetCursorPos({
                x = cpos.x + cell_size/2 - CalcStage.x/2,
                y = cpos.y + cell_size/2 - CalcStage.y/2
            })
            imgui.Text(tostring(data.stage_cell[i]-4))
        end
        cpos.x = cpos.x + cell_size -1
        if (i % data.square_lot.x) == 0 then cpos = {x = 40, y = cpos.y + cell_size -1 } end
    end
   if data.game_step == 0 then
        dl:AddRectFilled({
            x= WP.x + 40, y = WP.y + 40}, {
            x= WP.x + 40 + data.square_lot.x*cell_size-data.square_lot.x+1,
            y= WP.y + 40 + data.square_lot.y*cell_size-data.square_lot.y+1},
            0xBB000000, 7
        )
        local LoseTexts = {
            u8"К сожалению Вы проиграли.",
            u8"Но Вы можете попробовать снова!",
            u8"Ваша статистика:",
            u8("Время: "..convertime(data.end_time-data.start_time)),
            u8("Угадано флажков: "..data.true_flags)
        }

        for i, v in pairs(LoseTexts) do
            local CalcNowText = imgui.CalcTextSize(v)
            imgui.SetCursorPos({x=40+(data.square_lot.x*cell_size)/2-CalcNowText.x/2, y = 40 + CalcNowText.y*(i-1)})
            imgui.Text(v)
        end
    elseif data.game_step == 2 then
        dl:AddRectFilled({
            x= WP.x + 40, y = WP.y + 40}, {
            x= WP.x + 40 + data.square_lot.x*cell_size-data.square_lot.x+1,
            y= WP.y + 40 + data.square_lot.y*cell_size-data.square_lot.y+1},
            0xBB000000, 7
        )
        local WinText = {
            u8"Поздравляю, Вы победили!",
            u8"Можете попробовать более трудные комбинации!",
            u8("Ваше время: "..convertime(data.end_time-data.start_time))
        }

        for i, v in pairs(WinText) do
            local CalcNowText = imgui.CalcTextSize(v)
            imgui.SetCursorPos({x=40+(data.square_lot.x*cell_size)/2-CalcNowText.x/2, y = 40 + CalcNowText.y*(i-1)})
            imgui.Text(v)
        end
    end
    if data.game_step == 1 then data.end_time = os.time() end
    imgui.SetCursorPos({x=5, y=WinSize.y - imgui.CalcTextSize("@").y - 5})
    imgui.Text(convertime(data.end_time-data.start_time))
    local Kolvo = tostring((data.bombs-data.all_flags)..'/'..data.bombs)
    local KolvoSize = imgui.CalcTextSize(Kolvo)
    imgui.SetCursorPos({x = WinSize.x-5-KolvoSize.x*2,y = WinSize.y-5-KolvoSize.y})
    imgui.Text(Kolvo)
    imgui.SetCursorPos({x = WinSize.x-5-KolvoSize.x,y = WinSize.y-5-KolvoSize.y*2})
    imgui.Image(data.images.flag, imgui.ImVec2(KolvoSize.x, KolvoSize.y*2))
    imgui.SetCursorPos({x=0, y=0})
    imgui.Image(data.images.reset, {x=40,y=40})
    if imgui.IsItemHovered() then data.LockHovCell = true end
    if imgui.IsMouseReleased(0) and imgui.IsItemHovered() then StartSapper() end
    --


    ---
    imgui.SetCursorPos({x=WinSize.x-40, y=0})
    imgui.Image(data.images.settings, {x=40,y=40})
    if imgui.IsItemHovered() then data.LockHovCell = true end
   -- image
    if imgui.IsMouseReleased(0) and imgui.IsItemHovered() then data.ShowingMenu = not data.ShowingMenu end
    if data.ShowingMenu then
        if data.MenuAnimWindow ~= data.SMenuAnimWindow then
            data.MenuAnimWindow = data.MenuAnimWindow + data.SMenuAnimWindow/25
            if data.MenuAnimWindow >= data.SMenuAnimWindow then data.MenuAnimWindow = data.SMenuAnimWindow end
        else
            if data.MenuAnimText ~= data.SMenuAnimText then
                data.MenuAnimText = data.MenuAnimText + data.SMenuAnimText/25
                if data.MenuAnimText >= data.SMenuAnimText then data.MenuAnimText = data.SMenuAnimText
        end end end
    else
        if data.MenuAnimText ~= 0 then
            data.MenuAnimText = data.MenuAnimText - data.SMenuAnimText/25
            if data.MenuAnimText <= 0 then data.MenuAnimText = 0 end
        else
            if data.MenuAnimWindow ~= 0 then
                data.MenuAnimWindow = data.MenuAnimWindow - data.SMenuAnimWindow/25
                if data.MenuAnimWindow <= 0 then data.MenuAnimWindow = 0
    end end end end
    for k, _ in pairs(data.cells_anims) do
        data.cells_anims[k].NS = data.cells_anims[k].NS + data.cells_anims[k].Ss
        data.cells_anims[k].f = data.cells_anims[k].f -1
        if data.cells_anims[k].f <= 0 then
            data.cells_anims[k].func()
            data.cells_anims[k] = nil
        end
    end
    if data.MenuAnimWindow ~= 0 then
        imgui.End()
        imgui.PushStyleColorU32(imgui.Col.Button, 0x77117711)
        imgui.PushStyleColorU32(imgui.Col.ButtonHovered, 0x88228822)
        imgui.PushStyleColorU32(imgui.Col.ButtonActive, 0x99339933)
        imgui.PushStyleColorU32(imgui.Col.FrameBg, 0x77117711)
        imgui.PushStyleColorU32(imgui.Col.FrameBgHovered, 0x88228822)
        imgui.PushStyleColorU32(imgui.Col.FrameBgActive, 0x99339933)
        imgui.PushStyleColorU32(imgui.Col.SliderGrab, 0xAA44AA44)
        imgui.PushStyleColorU32(imgui.Col.SliderGrabActive, 0xBB55BB55)
        imgui.SetNextWindowBgAlpha(data.MenuAnimWindow/data.SMenuAnimWindow)
        imgui.SetNextWindowSize(imgui.ImVec2((data.MenuAnimWindow/data.SMenuAnimWindow)*230, -1))
        imgui.SetNextWindowPos(imgui.ImVec2(WinSize.x + WP.x + 1, WP.y))
        imgui.Begin("MENU", data.ValidAnim, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
        imgui.Text(u8"Выберете ниже количество бомб:")
        imgui.SetNextItemWidth(-1)
        imgui.SliderInt("##bombs", data.bombs_imgui, 1, (data.square_lot_imgui.x[0]*data.square_lot_imgui.y[0])-1)
        imgui.Text(u8"Выберете ниже ширину  поля:")
        imgui.SetNextItemWidth(-1)
        if imgui.SliderInt("##square_lotx", data.square_lot_imgui.x, 4, 30) then
            if ((data.square_lot_imgui.x[0]*data.square_lot_imgui.y[0])-1) < data.bombs_imgui[0] then
                data.bombs_imgui[0] = (data.square_lot_imgui.x[0]*data.square_lot_imgui.y[0])-1
            end
        end
        imgui.Text(u8"Выберете ниже длину поля:")
        imgui.SetNextItemWidth(-1)
        if imgui.SliderInt("##square_loty", data.square_lot_imgui.y, 4, 30) then
            if ((data.square_lot_imgui.x[0]*data.square_lot_imgui.y[0])-1) < data.bombs_imgui[0] then
                data.bombs_imgui[0] = (data.square_lot_imgui.x[0]*data.square_lot_imgui.y[0])-1
            end
        end
        if imgui.ToggleButton(u8"Блок перемещения окна", new.bool(data.LockWin)) then data.LockWin = not data.LockWin end
        imgui.Text(u8"Вы можете выбрать уровнь ниже:")
        if imgui.Button(u8"Лёгкий") then 
            data.square_lot_imgui.x[0] = 9
            data.square_lot_imgui.y[0] = 9
            data.bombs_imgui[0] = 10
        end imgui.SameLine()
        if imgui.Button(u8"Средний") then 
            data.square_lot_imgui.x[0] = 16
            data.square_lot_imgui.y[0] = 16
            data.bombs_imgui[0] = 40
        end imgui.SameLine()
        if imgui.Button(u8"Профи") then 
            data.square_lot_imgui.x[0] = 16
            data.square_lot_imgui.y[0] = 30
            data.bombs_imgui[0] = 99
        end
        imgui.PopStyleColor(8)
    end
   imgui.End()
end)
function convertime(time)
    local asd = ""
    if time <= 0 then return "0s" end
    if time > 60*60*24 then
        asd = asd..math.floor(time/60*60*24).."d "
        time = time - math.floor(time/60*60*24)*60*60*24
    end
    if time > 60*60 then
        asd = asd..math.floor(time/60*60).."h "
        time = time - math.floor(time/60*60)*60*60
    end
    if time > 60 then
        asd = asd..math.floor(time/60).."m "
        time = time - math.floor(time/60)*60
    end
    if time > 0 then asd = asd..time.."s " end
    return asd:sub(1)
end
function imgui.IsPosHovered(cpos, WP, cell_size, cellid)
    if cellid ~= nil and data.cells_anims[cellid] ~= nil then return false end
    local p1, p2 = {x=cpos.x+WP.x,y=cpos.y+WP.y}, {x = WP.x +cpos.x+cell_size, y = WP.y +cpos.y+cell_size}
    local m = imgui.GetMousePos()
    if m.x < math.max(p1.x, p2.x)-1 and m.x > math.min(p1.x, p2.x)+1 and  m.y < math.max(p1.y, p2.y)-1 and m.y > math.min(p1.y, p2.y)+1 then return true
    else return false end
end
function GetRoundings(cell)
    if data.cells_anims[cell] then return 1 + 2 + 4 + 8 end
    local ret = {[1] = false,[2] = false,[4] = false,[8] = false}
    local function isopen(i) return (data.stage_cell[i] > 2 and data.stage_cell[i] < 13) end
    if cell == 1 then
        ret[1] = true
    end
    if cell == data.square_lot.x then ret[2] = true end
    if cell == data.square_lot.x*(data.square_lot.y-1) + 1 then ret[4] = true end
    if cell == data.square_lot.x*data.square_lot.y then ret[8] = true end
    if cell > data.square_lot.x and cell%data.square_lot.x ~= 1 then -- TL
        if isopen(cell-1) and isopen(cell - data.square_lot.x) then
            ret[1] = true
        end
    end
    if cell > data.square_lot.x and cell%data.square_lot.x ~= 0 then
        if isopen(cell-data.square_lot.x) and isopen(cell+1) then
            ret[2] = true
        end
    end
    if cell%data.square_lot.x~=1 and cell+data.square_lot.x<=data.square_lot.x*data.square_lot.y then
        if isopen(cell-1) and isopen(cell+data.square_lot.x) then
            ret[4] = true
        end
    end
    if cell+data.square_lot.x<=data.square_lot.x*data.square_lot.y and cell%data.square_lot.x ~= 0 then
        if isopen(cell + 1) and isopen(cell+data.square_lot.x) then
            ret[8] = true
        end
    end
    if cell%data.square_lot.x == 0 then
        if cell > data.square_lot.x and isopen(cell - data.square_lot.x) then ret[2] = true end
        if cell+data.square_lot.x<=data.square_lot.x*data.square_lot.y and isopen(cell + data.square_lot.x) then ret[8] = true end
    end
    if cell%data.square_lot.x == 1 then
        if cell > data.square_lot.x and isopen(cell - data.square_lot.x) then ret[1] = true end
        if cell+data.square_lot.x<=data.square_lot.x*data.square_lot.y and isopen(cell + data.square_lot.x) then ret[4] = true end
    end
    if cell + data.square_lot.x > data.square_lot.x*data.square_lot.y then
        if cell%data.square_lot.x ~= 1 and isopen(cell-1) then ret[4] = true end
        if cell%data.square_lot.x ~= 0 and isopen(cell+1) then ret[8] = true end
    end
    if cell <= data.square_lot.x then
        if cell%data.square_lot.x ~= 1 and isopen(cell-1) then ret[1] = true end
        if cell%data.square_lot.x ~= 0 and isopen(cell+1) then ret[2] = true end
    end
    local ret2 = 0
    for k, v in pairs(ret) do if v then ret2 = ret2+k end end
    return ret2
end
function imgui.ToggleButton(text, bool, a_speed)
    local p  = imgui.GetCursorScreenPos()
    local dl = imgui.GetWindowDrawList()
    local bebrochka = false
    local label, label_true      = text or "", text or ""
    local h          = imgui.GetTextLineHeightWithSpacing() -- Высота кнопки
    local w,r,s      = h * 1.7, h / 2, a_speed or 0.2
    local function ImSaturate(f) return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f) end
    local x_begin = bool[0] and 1.0 or 0.0
    local t_begin = bool[0] and 0.0 or 1.0
    if LastTime == nil then LastTime = {} end
    if LastActive == nil then LastActive = {} end
    if imgui.InvisibleButton(label, imgui.ImVec2(w, h)) then
        bool[0] = not bool[0]
        LastTime[label] = os.clock()
        LastActive[label] = true
        bebrochka = true
    end
    if LastActive[label] then
        local time = os.clock() - LastTime[label]
        if time <= s then
            local anim = ImSaturate(time / s)
            x_begin = bool[0] and anim or 1.0 - anim
            t_begin = bool[0] and 1.0 - anim or anim
        else LastActive[label] = false end
    end
    local bg_color = imgui.ImVec4(x_begin * 0.13, x_begin * 0.9, x_begin * 0.13, imgui.IsItemHovered(0) and 0.7 or 0.9) -- Цвет прямоугольника
    local t_color  = imgui.ImVec4(1, 1, 1, x_begin) -- Цвет текста при false
    local t2_color = imgui.ImVec4(1, 1, 1, t_begin) -- Цвет текста при true
    dl:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + w, p.y + h), imgui.GetColorU32Vec4(bg_color), r)
    dl:AddCircleFilled(imgui.ImVec2(p.x + r + x_begin * (w - r * 2), p.y + r), t_begin < 0.5 and x_begin * r or t_begin * r, imgui.GetColorU32Vec4(imgui.ImVec4(0.9, 0.9, 0.9, 1.0)), r + 5)
    dl:AddText(imgui.ImVec2(p.x + w + r, p.y + r - (r / 2) - (imgui.CalcTextSize(label).y / 4)), imgui.GetColorU32Vec4(t_color), label_true)
    dl:AddText(imgui.ImVec2(p.x + w + r, p.y + r - (r / 2) - (imgui.CalcTextSize(label).y / 4)), imgui.GetColorU32Vec4(t2_color), label)
    return bebrochka
end
function GetNearFlags(cell)
    local nflags = 0
    local NearClosedCells = {}
    local sl = data.square_lot.x
    local function isflag(a) return (data.stage_cell[a] == 3) end
    if cell > sl then
        if isflag(cell - sl) then
            nflags = nflags + 1
        elseif data.stage_cell[cell - sl] < 3 then
            table.insert(NearClosedCells, cell - sl)
        end
        if cell%sl ~= 1 and isflag(cell - sl - 1) then
            nflags = nflags + 1
        elseif cell%sl ~= 1 and data.stage_cell[cell - sl - 1] < 3 then
            table.insert(NearClosedCells, cell - sl - 1)
        end
        if cell%sl ~= 0 and isflag(cell - sl + 1) then
            nflags = nflags + 1
        elseif cell%sl ~= 0 and data.stage_cell[cell - sl + 1] < 3 then
            table.insert(NearClosedCells, cell - sl + 1)
        end
    end
    if cell+sl <= sl*data.square_lot.y then
        if isflag(cell + sl) then
            nflags = nflags + 1
        elseif data.stage_cell[cell + sl] < 3 then
            table.insert(NearClosedCells, cell + sl)
        end
        if cell%sl ~= 1 and isflag(cell + sl - 1) then
            nflags = nflags + 1
        elseif cell%sl ~= 1 and data.stage_cell[cell + sl - 1] < 3 then
            table.insert(NearClosedCells, cell + sl - 1)
        end
        if cell%sl ~= 0 and isflag(cell + sl + 1) then
            nflags = nflags + 1
        elseif cell%sl ~= 0 and data.stage_cell[cell + sl + 1] < 3 then
            table.insert(NearClosedCells, cell + sl + 1)
        end
    end
    if cell%sl ~= 1 and isflag(cell - 1) then
        nflags = nflags + 1
    elseif cell%sl ~= 1 and data.stage_cell[cell - 1] < 3 then
        table.insert(NearClosedCells, cell - 1)
    end
    if cell%sl ~= 0 and isflag(cell + 1) then
        nflags = nflags + 1
    elseif cell%sl ~= 0 and data.stage_cell[cell + 1] < 3 then
        table.insert(NearClosedCells, cell + 1)
    end
    return nflags, NearClosedCells
end
function IsAllCellsClosed()
    for i = 1, data.square_lot.x*data.square_lot.y do if data.stage_cell[i] > 2 then return false end end
    return true
end
function CellsNear(cell1, cell2)
    if cell1 == cell2 then return true end
    local sl = data.square_lot.x
    if cell1 > sl then
        if cell2 == (cell1 - sl) then return true end
        if cell1%sl ~= 1 and cell2 == (cell1 - sl - 1) then return true end
        if cell1%sl ~= 0 and cell2 == (cell1 - sl + 1) then return true end
    end
    if cell1+sl <= sl*data.square_lot.y then
        if cell2 == (cell1 + sl) then return true end
        if cell1%sl ~= 1 and cell2 == (cell1 + sl - 1) then return true end
        if cell1%sl ~= 0 and cell2 == (cell1 + sl + 1) then return true end
    end
    if cell1%sl ~= 1 and cell2 == (cell1 - 1) then return true end
    if cell1%sl ~= 0 and cell2 == (cell1 + 1) then return true end
    return false
end