//
//  sdlframe.hpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 24..
//  Copyright © 2016년 장성각. All rights reserved.
//

#include "wx/wx.h"
#include "wx/splitter.h"
#include "SDL2/SDL.h"
#include "sdlwindow.hpp"

class SDL_Frame : public wxFrame
{
public:
    wxSDLWindow *sdl_window = nullptr;
    SDL_Renderer *renderer = nullptr;
    wxString *title;
    
    SDL_Frame(const wxString& title);
    void OnIdle(wxIdleEvent &);
    void OnClose(wxCloseEvent& event);
    
private:
    wxDECLARE_EVENT_TABLE();
};

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;
