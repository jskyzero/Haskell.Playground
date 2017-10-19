# -*- coding: utf-8 -*-
"""let char be char
"""

from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont


class PictureToAscii(object):
    """A PictureToAscii class"""

    def __init__(self):
        """initial a PictureToAscii class"""
        self.ascii = list("$@&%B#=-. ")

    def create_char_img(self, targrt_char):
        """create a char image"""
        self.ascii = targrt_char + " "
        new_image = Image.new("RGBA", (280, 500), (255, 255, 255))
        # new_image = Image.new("RGBA", (280, 330), (255, 255, 255))
        font = ImageFont.truetype('consola.ttf', 500)
        draw = ImageDraw.Draw(new_image)
        draw.text((0, 0), targrt_char, font=font, fill=(0,0,0,255))
        # new_image.save(targrt_char+".jpg", "PNG")
        return new_image

    def main_func(self, target_string):
        """process every char in target_string
        """
        with open("output", "w") as out:
            for targrt_char in target_string:
                out.write(self.picture_to_ascii(targrt_char, (56,50)))
                out.write("\\\n\\")

    def picture_to_ascii(self, targrt_char, size):
        """process picture in pic_path, return ascii data
        if size == None, let size be default size
        """
        pic = self.create_char_img(targrt_char)

        width, height = self.default_size(pic.size) if size is None else size
        pic = pic.resize((width, height), Image.NEAREST)

        return "\\\n\\".join([
            "".join([self.rgba_to_char(*pic.getpixel((y, x)))
                     for y in range(width)])
            for x in range(height)])

    def rgb_to_gray(self, red, green, blue):
        """use color's RBG value to calculate a gray value
        """
        return int((19595 * red + 38469 * green + 7472 * blue) >> 16)

    def rgba_to_char(self, red, green, blue, alpha=256):
        """use gray value to select a char in self.ascii
        """
        gray = self.rgb_to_gray(red, green, blue)
        unit = (256.0 + 1) / len(self.ascii)
        return ' ' if alpha == 0 else self.ascii[int(gray / unit)]

    def default_size(self, pic_size):
        """return default size accodinf to pic_size
        """
        width, height = pic_size
        height /= 2
        while width > 100 or height > 50:
            width /= 2
            height /= 2
        return int(width), int(height)


if __name__ == "__main__":
    app = PictureToAscii()
    app.main_func(" 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    # app.main_func("ABQ")
    