<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Video Browsing System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!--CSS file path-->
    <link rel="stylesheet" href="css/Home.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">  
</head>

<body>

    <!--NAVIGATION BAR-->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
          <a class="navbar-brand fs-3 fw-bold d-flex align-items-center" href="#">
            <i class="fas fa-gamepad me-2"></i>
            <span>GameHUB</span>
          </a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarScroll">
            <ul class="navbar-nav me-auto">
              <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="#">Home</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">Trending</a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Categories
                </a>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#">Games</a></li>
                  <li><a class="dropdown-item" href="#">Entertainment</a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="#">Multiplayer</a></li>
                </ul>
              </li>
              <!--<li class="nav-item">
                <a class="nav-link" href="#">Live</a>
              </li>-->
              
            </ul>
                <form class="d-flex search-form me-3">
                    <div class="input-group">
                        <input class="form-control search-input" type="search" placeholder="Search videos..." aria-label="Search">
                        <button class="btn search-btn" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
                <div class="d-flex auth-buttons">
                    <button class="btn login-btn me-2">Login</button>
                    <button class="btn signup-btn">Sign Up</button>
                </div>
          </div>
        </div>
      </nav>


      <!--SLIDER HERO SECTION-->
    <div class="hero-section">
      <div class="container">
        <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel" >
          <div class="carousel-inner">
            <div class="carousel-item active">
              <div class="slider-item" style="background-image: url('${pageContext.request.contextPath}/pictures/slider1.png')">
                <div class="slider-content">
                    <span class="badge slider-badge">TRENDING</span>
                    <h2>Call of Duty: Black Ops 6 - Ultimate Guide</h2>
                    <p>Watch the most comprehensive guide to mastering the campaign, multiplayer, and Zombies mode in Call of Duty: Black Ops 6</p>
                    <button class="btn slider-btn"><i class="fas fa-play me-2"></i>WATCH NOW</button>
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="slider-item" style="background-image: url('${pageContext.request.contextPath}/pictures/slider2.png')">
                <div class="slider-content">
                    <span class="badge slider-badge">LIVE</span>
                    <h2>Elden Ring: Ultimate Boss Guide</h2>
                    <p>Watch the most comprehensive guide to defeating all bosses in Elden Ring</p>
                    <button class="btn slider-btn"><i class="fas fa-play me-2"></i>WATCH NOW</button>
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="slider-item" style="background-image: url('${pageContext.request.contextPath}/pictures/slider3.png')">
                <div class="slider-content">
                    <span class="badge slider-badge">LIVE</span>
                    <h2>Elden Ring: Ultimate Boss Guide</h2>
                    <p>Watch the most comprehensive guide to defeating all bosses in Elden Ring</p>
                    <button class="btn slider-btn"><i class="fas fa-play me-2"></i>WATCH NOW</button>
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="slider-item" style="background-image: url('${pageContext.request.contextPath}/pictures/slider4.png')">
                <div class="slider-content">
                    <span class="badge slider-badge">LIVE</span>
                    <h2>Elden Ring: Ultimate Boss Guide</h2>
                    <p>Watch the most comprehensive guide to defeating all bosses in Elden Ring</p>
                    <button class="btn slider-btn"><i class="fas fa-play me-2"></i>WATCH NOW</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


    <!--GAMING CATEGORIES SECTION GRID-->
    <div class="categories mt-5">
      <div class="container">
        <div class="section-header">
          <h3>Browse Categories</h3>
              <a href="#" class="view-all">View All <i class="fas fa-chevron-right"></i></a>
        </div>

        <div class="row">
          <div class="col-6 col-md-3 col-lg-2">
              <div class="categories-item">
                  <div class="categories-icon">
                    <i class="fas fa-gamepad"></i>
                  </div>
                  <h5>Action</h5>
              </div>
          </div>

          <div class="col-6 col-md-3 col-lg-2">
              <div class="categories-item">
                  <div class="categories-icon">
                    <i class="fas fa-crosshairs"></i>
                  </div>
                  <h5>FPS</h5>
              </div>
          </div>

          <div class="col-6 col-md-3 col-lg-2">
              <div class="categories-item">
                  <div class="categories-icon">
                    <i class="fas fa-car"></i>
                  </div>
                  <h5>Racing</h5>
              </div>
          </div>

          <div class="col-6 col-md-3 col-lg-2">
            <div class="categories-item">
                <div class="categories-icon">
                  <i class="fas fa-futbol"></i>
                </div>
                <h5>Sports</h5>
            </div>
        </div>

        <div class="col-6 col-md-3 col-lg-2">
          <div class="categories-item">
              <div class="categories-icon">
                <i class="fas fa-hat-wizard"></i>
              </div>
              <h5>RPG</h5>
          </div>
        </div>

        <div class="col-6 col-md-3 col-lg-2">
          <div class="categories-item">
              <div class="categories-icon">
                <i class="fas fa-chess"></i>
              </div>
              <h5>Strategy</h5>
          </div>
        </div>

        </div>
      </div>
    </div>

    <!--TRENDING VIDEOS-->
    <div class="trending-videos mt-5">
      <div class="container">
        <div class="section-header">
            <h3>Trending Now</h3>
            <a href="#" class="view-all">View All <i class="fas fa-chevron-right"></i></a>
        </div>
        <div class="row">
            <div class="col-md-6 col-lg-3 mb-4">
                <div class="video-card">
                    <div class="video-thumbnail">
                        <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                        <span class="video-duration">45.12</span>
                        <div class="play-hover"><i class="fas fa-play"></i></div>
                    </div>
                    <div class="video-info">
                        <div class="channel-logo">
                            <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                        </div>
                        <div class="video-details">
                            <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                            <p class="channel-name">CODbuddy</p>
                            <div class="video-views">
                                <span>245K views</span>
                                <span>•</span>
                                <span>1 days ago</span>
                            </div>
                        </div>
                    </div>
                </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                  <div class="video-card">
                      <div class="video-thumbnail">
                          <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                          <span class="video-duration">45.12</span>
                          <div class="play-hover"><i class="fas fa-play"></i></div>
                      </div>
                      <div class="video-info">
                          <div class="channel-logo">
                              <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                          </div>
                          <div class="video-details">
                              <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                              <p class="channel-name">CODbuddy</p>
                              <div class="video-views">
                                  <span>245K views</span>
                                  <span>•</span>
                                  <span>1 days ago</span>
                              </div>
                          </div>
                      </div>
                  </div>
                </div>

                  <div class="col-md-6 col-lg-3 mb-4">
                    <div class="video-card">
                        <div class="video-thumbnail">
                            <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                            <span class="video-duration">45.12</span>
                            <div class="play-hover"><i class="fas fa-play"></i></div>
                        </div>
                        <div class="video-info">
                            <div class="channel-logo">
                                <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                            </div>
                            <div class="video-details">
                                <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                                <p class="channel-name">CODbuddy</p>
                                <div class="video-views">
                                    <span>245K views</span>
                                    <span>•</span>
                                    <span>1 days ago</span>
                                </div>
                            </div>
                        </div>
                    </div>
                  </div>

                  <div class="col-md-6 col-lg-3 mb-4">
                      <div class="video-card">
                          <div class="video-thumbnail">
                              <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                              <span class="video-duration">45.12</span>
                              <div class="play-hover"><i class="fas fa-play"></i></div>
                          </div>
                          <div class="video-info">
                              <div class="channel-logo">
                                  <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                              </div>
                              <div class="video-details">
                                  <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                                  <p class="channel-name">CODbuddy</p>
                                  <div class="video-views">
                                      <span>245K views</span>
                                      <span>•</span>
                                      <span>1 days ago</span>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
   
              </div>
          </div>
    </div>

    <!--TOP (POPULAR) CREATORS SECTION-->
    <div class="popular-creators mt-5">
      <div class="container">
        <div class="section-header">
          <h3>Popular Creators</h3>
              <a href="#" class="view-all">View All <i class="fas fa-chevron-right"></i></a>
        </div>

        <div class="row">
          <div class="col-6 col-md-3 col-lg-2">
              <div class="creator-card">
                  <div class="creator-icon">
                    <img src="${pageContext.request.contextPath}/pictures/popular1.jpg" alt="Content Creator icon">
                  </div>
                  <h5>CODbuddy</h5>
                  <p>10.8M Subscribers</p>
                  <button class="btn subscribe-btn">Subscribe</button>
              </div>
          </div>

          <div class="col-6 col-md-3 col-lg-2">
            <div class="creator-card">
                <div class="creator-icon">
                  <img src="${pageContext.request.contextPath}/pictures/popular1.jpg" alt="Content Creator icon">
                </div>
                <h5>CODbuddy</h5>
                <p>10.8M Subscribers</p>
                <button class="btn subscribe-btn">Subscribe</button>
            </div>
        </div>

          <div class="col-6 col-md-3 col-lg-2">
              <div class="creator-card">
                  <div class="creator-icon">
                    <img src="${pageContext.request.contextPath}/pictures/popular1.jpg" alt="Content Creator icon">
                  </div>
                  <h5>CODbuddy</h5>
                  <p>10.8M Subscribers</p>
                  <button class="btn subscribe-btn">Subscribe</button>
              </div>
          </div>

          <div class="col-6 col-md-3 col-lg-2">
            <div class="creator-card">
                <div class="creator-icon">
                  <img src="${pageContext.request.contextPath}/pictures/popular1.jpg" alt="Content Creator icon">
                </div>
                <h5>CODbuddy</h5>
                <p>10.8M Subscribers</p>
                <button class="btn subscribe-btn">Subscribe</button>
            </div>
          </div>

          <div class="col-6 col-md-3 col-lg-2">
            <div class="creator-card">
                <div class="creator-icon">
                  <img src="${pageContext.request.contextPath}/pictures/popular1.jpg" alt="Content Creator icon">
                </div>
                <h5>CODbuddy</h5>
                <p>10.8M Subscribers</p>
                <button class="btn subscribe-btn">Subscribe</button>
            </div>
          </div>

          <div class="col-6 col-md-3 col-lg-2">
            <div class="creator-card">
                <div class="creator-icon">
                  <img src="${pageContext.request.contextPath}/pictures/popular1.jpg" alt="Content Creator icon">
                </div>
                <h5>CODbuddy</h5>
                <p>10.8M Subscribers</p>
                <button class="btn subscribe-btn">Subscribe</button>
            </div>
          </div>

        </div>
      </div>
    </div>

    <!--Recommended for You-->
    <div class="all-videos mt-5">
      <div class="container">
        <div class="section-header">
            <h3>Recommended for You</h3>
            <a href="#" class="view-all">View All <i class="fas fa-chevron-right"></i></a>
        </div>
        <div class="row">
            <div class="col-md-6 col-lg-3 mb-4">
                <div class="video-card">
                    <div class="video-thumbnail">
                        <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                        <span class="video-duration">45.12</span>
                        <div class="play-hover"><i class="fas fa-play"></i></div>
                    </div>
                    <div class="video-info">
                        <div class="channel-logo">
                            <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                        </div>
                        <div class="video-details">
                            <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                            <p class="channel-name">CODbuddy</p>
                            <div class="video-views">
                                <span>245K views</span>
                                <span>•</span>
                                <span>1 days ago</span>
                            </div>
                        </div>
                    </div>
                </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                  <div class="video-card">
                      <div class="video-thumbnail">
                          <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                          <span class="video-duration">45.12</span>
                          <div class="play-hover"><i class="fas fa-play"></i></div>
                      </div>
                      <div class="video-info">
                          <div class="channel-logo">
                              <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                          </div>
                          <div class="video-details">
                              <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                              <p class="channel-name">CODbuddy</p>
                              <div class="video-views">
                                  <span>245K views</span>
                                  <span>•</span>
                                  <span>1 days ago</span>
                              </div>
                          </div>
                      </div>
                  </div>
                </div>

                  <div class="col-md-6 col-lg-3 mb-4">
                    <div class="video-card">
                        <div class="video-thumbnail">
                            <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                            <span class="video-duration">45.12</span>
                            <div class="play-hover"><i class="fas fa-play"></i></div>
                        </div>
                        <div class="video-info">
                            <div class="channel-logo">
                                <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                            </div>
                            <div class="video-details">
                                <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                                <p class="channel-name">CODbuddy</p>
                                <div class="video-views">
                                    <span>245K views</span>
                                    <span>•</span>
                                    <span>1 days ago</span>
                                </div>
                            </div>
                        </div>
                    </div>
                  </div>

                  <div class="col-md-6 col-lg-3 mb-4">
                      <div class="video-card">
                          <div class="video-thumbnail">
                              <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                              <span class="video-duration">45.12</span>
                              <div class="play-hover"><i class="fas fa-play"></i></div>
                          </div>
                          <div class="video-info">
                              <div class="channel-logo">
                                  <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                              </div>
                              <div class="video-details">
                                  <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                                  <p class="channel-name">CODbuddy</p>
                                  <div class="video-views">
                                      <span>245K views</span>
                                      <span>•</span>
                                      <span>1 days ago</span>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
   
              </div>

              <div class="row">
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="video-card">
                        <div class="video-thumbnail">
                            <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                            <span class="video-duration">45.12</span>
                            <div class="play-hover"><i class="fas fa-play"></i></div>
                        </div>
                        <div class="video-info">
                            <div class="channel-logo">
                                <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                            </div>
                            <div class="video-details">
                                <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                                <p class="channel-name">CODbuddy</p>
                                <div class="video-views">
                                    <span>245K views</span>
                                    <span>•</span>
                                    <span>1 days ago</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
    
                    <div class="col-md-6 col-lg-3 mb-4">
                      <div class="video-card">
                          <div class="video-thumbnail">
                              <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                              <span class="video-duration">45.12</span>
                              <div class="play-hover"><i class="fas fa-play"></i></div>
                          </div>
                          <div class="video-info">
                              <div class="channel-logo">
                                  <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                              </div>
                              <div class="video-details">
                                  <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                                  <p class="channel-name">CODbuddy</p>
                                  <div class="video-views">
                                      <span>245K views</span>
                                      <span>•</span>
                                      <span>1 days ago</span>
                                  </div>
                              </div>
                          </div>
                      </div>
                    </div>
    
                      <div class="col-md-6 col-lg-3 mb-4">
                        <div class="video-card">
                            <div class="video-thumbnail">
                                <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                                <span class="video-duration">45.12</span>
                                <div class="play-hover"><i class="fas fa-play"></i></div>
                            </div>
                            <div class="video-info">
                                <div class="channel-logo">
                                    <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                                </div>
                                <div class="video-details">
                                    <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                                    <p class="channel-name">CODbuddy</p>
                                    <div class="video-views">
                                        <span>245K views</span>
                                        <span>•</span>
                                        <span>1 days ago</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                      </div>
    
                      <div class="col-md-6 col-lg-3 mb-4">
                          <div class="video-card">
                              <div class="video-thumbnail">
                                  <img src="${pageContext.request.contextPath}/pictures/trending1.png" alt="video thumbnail image">
                                  <span class="video-duration">45.12</span>
                                  <div class="play-hover"><i class="fas fa-play"></i></div>
                              </div>
                              <div class="video-info">
                                  <div class="channel-logo">
                                      <img src="${pageContext.request.contextPath}/pictures/channel_logo1.jpg" alt="Channel-logo">
                                  </div>
                                  <div class="video-details">
                                      <h5 class="video-title">Call of Duty: Black Ops 6</h5>
                                      <p class="channel-name">CODbuddy</p>
                                      <div class="video-views">
                                          <span>245K views</span>
                                          <span>•</span>
                                          <span>1 days ago</span>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
       
                  </div>
          </div>
    </div>





    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
