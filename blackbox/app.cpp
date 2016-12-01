#include "app.hpp"

using namespace cv;
using namespace std;

bool MyApp::OnInit()
{
    wxPuts(wxT("A wxWidgets console application"));
    // make sure to call this first
    wxInitAllImageHandlers();
    
    menuBar = new AppMenuBar();

    SDL_Frame *sdl_frame = new SDL_Frame("SDL Frame INIT");
    sdl_frame->SetMenuBar(menuBar);
    sdl_frame->Show();
    
//    wxNativeWindow *nwindow = new wxNativeWindow();
//    SDL_Window *swindow = SDL_CreateWindow(
//                                    "An SDL2 window",                  // window title
//                                    SDL_WINDOWPOS_UNDEFINED,           // initial x position
//                                    SDL_WINDOWPOS_UNDEFINED,           // initial y position
//                                    640,                               // width, in pixels
//                                    480,                               // height, in pixels
//                                    SDL_WINDOW_OPENGL                  // flags - see below
//                                );
//    SDL_SysWMinfo info;
//    SDL_VERSION(&info.version);
//    if(SDL_GetWindowWMInfo(swindow, &info)) {
//        wxNativeWindow* nwindow = new wxNativeWindow(frame, wxID_ANY, getContentViewFromNSWindow(info.info.cocoa.window));
//        //nwindow->Show();
//    };
    
    
    
    
    return true;
}

IMPLEMENT_APP(MyApp)
