#include "sdlwindow.hpp"

BEGIN_EVENT_TABLE(wxSDLWindow, wxWindow)
    EVT_PAINT(wxSDLWindow::OnPaint)
    EVT_TIMER(SDL_WINDOW_TIMER_ID, wxSDLWindow::OnTimer)
    EVT_IDLE(wxSDLWindow::OnIdle)
END_EVENT_TABLE()

void fillTexture(SDL_Texture * texture, Mat mat)
{
    IplImage * img = new IplImage(mat);
    
    unsigned char * texture_data = NULL;
    int texture_pitch = 0;
    
    SDL_LockTexture(texture, 0, (void **)&texture_data, &texture_pitch);
    memcpy(texture_data, (void *)img->imageData, img->width * img->height * img->nChannels);
    SDL_UnlockTexture(texture);
}

wxSDLWindow::wxSDLWindow(wxWindow* parent, wxSize const& size)
: wxWindow(parent, wxID_ANY, wxDefaultPosition, size)
,timer(this, SDL_WINDOW_TIMER_ID)
{
    //SetBackgroundColour(wxColour(_T("rgba(255,255,255,0.5)")));
    
    cap.open(0);
    
    if (!cap.isOpened())
    {
        std::cerr << "***Could not initialize capturing...***" << std::endl;
        return;
    }


    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        std::cerr << "SDL Initialisation Error\n\n";
        return;
    }
    
    window = SDL_CreateWindowFrom((__bridge void *)GetNSWindowFromNSView((NSView *)GetHandle()));
    
    wxPuts(_T("Start"));
    
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE);

    assert(window && renderer);
    
    texture = SDL_CreateTexture(
                                renderer,
                                SDL_PIXELFORMAT_BGR24,
                                SDL_TEXTUREACCESS_STREAMING,
                                (int)cap.get(cv::CAP_PROP_FRAME_WIDTH),
                                (int)cap.get(cv::CAP_PROP_FRAME_HEIGHT)
                                );
    
    myRect = new MyRect(renderer, 0, 0, 100, 100);
    
    timer.Start(10);
}

void wxSDLWindow::OnIdle(wxIdleEvent &) {
    CreateSurface();
    Lock();
    SDL_RenderReadPixels(renderer, NULL, SDL_PIXELFORMAT_RGB24, surface->pixels, surface->pitch);
    Unlock();
    Refresh(false);
    wxMilliSleep(33);
}

void wxSDLWindow::CreateSurface() {
    GetClientSize(&_width, &_height);
    
    if (surface == NULL)
    {
        surface = SDL_CreateRGBSurface(0,
                                       _width, _height, 24, 0, 0, 0, 0);
    }

    else if( surface->w != _width || surface->h != _height )
    {
        SDL_FreeSurface( surface );
        surface = SDL_CreateRGBSurface(0,
                                       _width, _height, 24, 0, 0, 0, 0);
    }
}

void wxSDLWindow::Lock()
{
    // Lock surface if needed
    if (SDL_MUSTLOCK(surface)) {
        if (SDL_LockSurface(surface) < 0) {
            return;
        }
    }
}

void wxSDLWindow::Unlock()
{
    // Unlock if needed
    if (SDL_MUSTLOCK(surface)) {
        SDL_UnlockSurface(surface);
    }
}

void wxSDLWindow::OnPaint(wxPaintEvent& event)
{
    if (surface == NULL) {
        return;
    }
    Lock();
    wxBitmap bmp(wxImage(surface->w, surface->h,
                        static_cast<unsigned char *>(surface->pixels), true));
    Unlock();
    wxBufferedPaintDC dc(this, bmp);
}

void wxSDLWindow::OnTimer(wxTimerEvent&) {
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderClear(renderer);
    
//    while (SDL_PollEvent(&event)) {
//        switch(event.type) {
//            case SDL_QUIT:
//                Close();
//                break;
//            case SDL_KEYDOWN:
//                wxPuts(_T("KEY DOWN"));
//                switch(event.key.keysym.sym) {
//                    case SDLK_DOWN:
//                        myRect->SetPositionY(myRect->r.y + 15);
//                        break;
//                }
//                break;
//        }
//    }

    cap >> frame;
    
    if (frame.empty())
    {
        Close();
    }
    
    fillTexture(texture, frame);

    SDL_RenderCopy(renderer, texture, NULL, NULL);
    
    myRect->render();
    
    SDL_RenderPresent(renderer);
}

void wxSDLWindow::Close()
{
    timer.Stop();
    cap.release();
    if(window != NULL) {
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit();
    }
}
