# pixel-art
This is a project to generate moving pixels from an image by [Processing](https://processing.org/).
<img width="320px" src="https://github.com/tomoyukim/pixel-art-study/blob/master/example/zakuhead.gif">

## Change image size
Change `DISPLAY_SIZE` in `Size` class.
```java
class Size {
  private float DISPLAY_RATIO = 0.8;
  ...
}
```

## Example: generating gif animation
Just captureing fullscreen desktop movie and using [ffmpeg](https://ffmpeg.org/) to generate gif animation file.
```shell
$ ffmpeg -i {captured_movie}.mov -vf scale=320:1 -r 10 {output}.gif
```