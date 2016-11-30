#include "sdlframe.hpp"

BEGIN_EVENT_TABLE(SDL_Frame, wxFrame)
    EVT_IDLE(SDL_Frame::OnIdle)
    EVT_CLOSE(SDL_Frame::OnClose)
END_EVENT_TABLE()

SDL_Frame::SDL_Frame(const wxString& title) : wxFrame(NULL, wxID_ANY, title)
{
    auto self_size = wxSize(800, 600);
    SetSize(self_size);
    SetMaxSize(self_size);
    SetMinSize(self_size);
    

    sdl_window = new wxSDLWindow(this, wxSize(800, 600));

    CreateStatusBar(1);
    SetStatusText(_T("Application Init"));
    Centre();
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
