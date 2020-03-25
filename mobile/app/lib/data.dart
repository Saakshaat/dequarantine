class Data {
  List _discoverable = [
    ["0vO9X-knpW0.jpg", 1],
    ["4_65Wvc1-oI.jpg", 3],
    ["bYTyQ8V09IU.jpg", 3],
    ["cl2BbKzycQE.jpg", 2],
    ["dxWNH-l_zvg.jpg", 1],
    ["FcDqdJUM6B4.jpg", 3],
    ["hqUkno6qO9Q.jpg", 2],
    ["I2t7NJNJHgs.jpg", 1],
    ["ifffeYgdQko.jpg", 4],
    ["ixgRYSGBMaM.jpg", 2],
    ["i_k-ttpyw3E.jpg", 1],
    ["J7IBavYCdUA.jpg", 3],
    ["n2LTC8aGPMM.jpg", 1],
    ["OdoW3-o62EM.jpg", 3],
    ["r86MVAPvWss.jpg", 2],
    ["RQMUxzwfH-s.jpg", 1],
    ["stO13Ofaq-o.jpg", 1],
    ["SUbFt_dqj3w.jpg", 4],
    ["u13HfR5XjUI.jpg", 4],
    ["ZDDwSNHWQJo.jpg", 1],
  ];
  List _liked = [
    ["OdoW3-o62EM.jpg", 3],
    ["r86MVAPvWss.jpg", 2],
    ["RQMUxzwfH-s.jpg", 1],
    ["stO13Ofaq-o.jpg", 1],
    ["SUbFt_dqj3w.jpg", 4],
    ["u13HfR5XjUI.jpg", 4],
    ["ZDDwSNHWQJo.jpg", 1],
  ];

  List getDiscover() {
    return _discoverable;
  }

  List getLiked() {
    return _liked;
  }

  removeDiscover(int index) {
    _discoverable.removeAt(index);
  }

  removeliked(int index) {
    _liked.removeAt(index);
  }

  addLiked(List item) {
    _liked.add(item);
  }
}