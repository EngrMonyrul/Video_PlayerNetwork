class Video {
  final String name;
  final String url;
  final String thum;

  const Video({
    required this.name,
    required this.url,
    required this.thum,
  });
}

const videos = [
  Video(
    name: 'Big Buck Bunny',
    url:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    thum: 'images/BigBuckBunny.jpg',
  ),
  Video(
    name: 'Elephant Dream',
    url:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    thum: 'images/ElephantsDream.jpg',
  ),
  Video(
    name: 'For Bigger Blazes',
    url:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    thum: 'images/ForBiggerBlazes.jpg',
  ),
  
];
