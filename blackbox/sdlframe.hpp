#include "wx/wx.h"
#include "wx/splitter.h"
#include "SDL2/SDL.h"
#include "sdlwindow.hpp"
#include "controlpanel.hpp"
#include "imagepanel.hpp"

class SDL_Frame : public wxFrame
{
public:
    wxSDLWindow *sdl_window = nullptr;
    SDL_Renderer *renderer = nullptr;
    wxString *title;
    wxImagePanel *drawPanel = nullptr;
    wxControlPanel *ctrlPanel = nullptr;
    
    SDL_Frame(const wxString& title);
    void OnIdle(wxIdleEvent &);
    void OnClose(wxCloseEvent& event);
    
private:
    wxDECLARE_EVENT_TABLE();
};

const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;
