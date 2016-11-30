//
//  sdlframe.cpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 24..
//  Copyright © 2016년 장성각. All rights reserved.
//

#include "sdlframe.hpp"

BEGIN_EVENT_TABLE(SDL_Frame, wxFrame)
    EVT_IDLE(SDL_Frame::OnIdle)
    EVT_CLOSE(SDL_Frame::OnClose)
END_EVENT_TABLE()

SDL_Frame::SDL_Frame(const wxString& title) : wxFrame(NULL, wxID_ANY, title)
{
    auto self_size = wxSize(800, 600);
    SetSize(self_size);
    wxSplitterWindow *splitter = new wxSplitterWindow(this);
    
    sdl_window = new wxSDLWindow(splitter, wxSize(800, 600));
    
    wxPanel* panel = new wxPanel(splitter);
    panel->Show();
    
    
//
//    SDL_CreateWindowFrom((__bridge void *)GetNSWindowFromNSView((NSView *)GetHandle()));
#if wxUSE_STATUSBAR
    // create a status bar just for fun (by default with 1 pane only)
//    CreateStatusBar(1);
//    SetStatusText(_T("SDL Window Init"));
#endif
    
    
//    wxColour col1;
//    col1.Set(wxT("rgba(255, 255, 255, 0.8)"));
//    
//    SetBackgroundColour(col1);
}

void SDL_Frame::OnIdle(wxIdleEvent &)
{
   
}

void SDL_Frame::OnClose(wxCloseEvent& event)
{
//    if (event.CanVeto())
//    {
//        int userAnswer = wxMessageBox("Are you sure you want to exit?",
//                                      "Close Confirmation",
//                                      wxICON_QUESTION | wxYES_NO);
//        
//        if ( userAnswer != wxYES )
//        {
//            event.Veto();
//            return;
//        }
//    }
    if(sdl_window != NULL) {
        sdl_window->Close();
    }
    Destroy();
}
