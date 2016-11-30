//
//  sdlwindow.cpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 28..
//  Copyright © 2016년 장성각. All rights reserved.
//

#include "sdlwindow.hpp"

BEGIN_EVENT_TABLE(wxSDLWindow, wxWindow)
    EVT_PAINT(wxSDLWindow::OnPaint)
    EVT_TIMER(SDL_WINDOW_TIMER_ID, wxSDLWindow::OnTimer)
    EVT_IDLE(wxSDLWindow::OnIdle)
END_EVENT_TABLE()

wxSDLWindow::wxSDLWindow(wxWindow* parent, wxSize const& size)
: wxWindow(parent, wxID_ANY, wxDefaultPosition, size)
,timer(this, SDL_WINDOW_TIMER_ID)
{
    
    //NSView *ns_view = (NSView *) GetHandle();
    //window = SDL_CreateWindowFrom((__bridge void *) GetHandle());
    
    //window = SDL_CreateWindowFrom((void *) this);
    //wxNativeWindow* native_window = new wxNativeWindow(parent, wxID_ANY, (wxNativeWindowHandle*)window);
    //NSView *ns_view = (NSView *) GetHandle();
    //NSWindow *ns_window = [ns_view window];
    
    //window = SDL_CreateWindowFrom((__bridge void *) ns_window);
    //window = SDL_CreateWindowFrom((__bridge void *) GetHandle());
    
    //SetBackgroundColour(wxColour(_T("rgba(255,255,255,0.5)")));
    
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        std::cerr << "SDL Initialisation Error\n\n";
    }
    
    window = SDL_CreateWindow(
                              "An SDL2 window",                  // window title
                              SDL_WINDOWPOS_CENTERED,           // initial x position
                              SDL_WINDOWPOS_CENTERED,           // initial y position
                              800,                               // width, in pixels
                              600,                               // height, in pixels
                              SDL_WINDOW_OPENGL                                                      );
    // flags - see below

    //window = SDL_CreateWindowFrom((__bridge void *)GetNSWindowFromNSView((NSView *)GetHandle()));
    
    wxPuts(_T("Start"));
    
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE);

    assert(window && renderer);
    
    myRect = new MyRect(renderer, 0, 0, 100, 100);
    
    timer.Start(10);
}

void wxSDLWindow::OnIdle(wxIdleEvent &) {
    // create the SDL_Surface
//    CreateSurface();
//
//    Lock();
    
// Ask SDL for the time in milliseconds
//    int tick = SDL_GetTicks();
    
//    for (int y = 0; y < 600; y++) {
//        for (int x = 0; x < 800; x++) {
//            wxUint32 color = (y * y) + (x * x) + tick;
//            wxUint8 *pixels = static_cast<wxUint8 *>(surface->pixels) +
//            (y * surface->pitch) +
//            (x * surface->format->BytesPerPixel);
//            
//#if SDL_BYTEORDER == SDL_BIG_ENDIAN
//            pixels[0] = color & 0xFF;
//            pixels[1] = (color >> 8) & 0xFF;
//            pixels[2] = (color >> 16) & 0xFF;
//#else
//            pixels[0] = (color >> 16) & 0xFF;
//            pixels[1] = (color >> 8) & 0xFF;
//            pixels[2] = color & 0xFF;
//#endif
//        }
//    }
    
//    SDL_RenderReadPixels(renderer, NULL, SDL_PIXELFORMAT_RGB24, surface->pixels, surface->pitch);
//    
//    Unlock();
//
//    
//    Refresh(false);
//
//    wxMilliSleep(33);
}

void wxSDLWindow::CreateSurface() {
    GetClientSize(&_width, &_height);
    
    if (surface == NULL)
    {
        surface = SDL_CreateRGBSurface(0,
                                       _width, _height, 24, 0, 0, 0, 0);
    }
    // Size has changed - nuke and redo.
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
// can't draw if the surface doesn't exist yet
//    if (surface == NULL) {
//        return;
//    }
//    
//    Lock();
//    
//    wxBitmap bmp(wxImage(surface->w, surface->h,
//                        static_cast<unsigned char *>(surface->pixels), true));
//
//    Unlock();
//    
//    wxBufferedPaintDC dc(this, bmp);
}

void wxSDLWindow::OnTimer(wxTimerEvent&) {
    
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderClear(renderer);
    
    while (SDL_PollEvent(&event)) {
        switch(event.type) {
            case SDL_QUIT:
                timer.Stop();
                Close();
                break;
            case SDL_KEYDOWN:
                wxPuts(_T("KEY DOWN"));

                switch(event.key.keysym.sym) {
                    case SDLK_DOWN:
                        myRect->SetPositionY(myRect->r.y + 1);
                        break;
                }
                break;
        }
    }
    
    myRect->render();
    
//    SDL_Rect r;
//    r.x = 150;
//    r.y = 150;
//    r.w = 150;
//    r.h = 150;
//    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
//    SDL_RenderFillRect( renderer, &r );
    
    SDL_RenderPresent(renderer);
}

void wxSDLWindow::Close()
{
    if(window != NULL) {
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit();
    }
    //Destroy();
}
