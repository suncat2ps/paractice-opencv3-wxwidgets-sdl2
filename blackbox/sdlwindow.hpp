#include "wx/wx.h"
#include "wx/nativewin.h"
#include "wx/dcbuffer.h"
#include "SDL2/SDL.h"
#include "SDL2/SDL_syswm.h"
#include "MyRect.hpp"

#include "ObjectiveCInterface.h"


class wxSDLWindow : public wxWindow
{
public:
    int _width;
    int _height;
    unsigned int *m_buffer;
    MyRect *myRect;
    SDL_Event event;


    wxSDLWindow(wxWindow* parent, wxSize const& size);
    void OnIdle(wxIdleEvent &);
    void CreateSurface();
    void OnPaint(wxPaintEvent& event);
    void OnTimer(wxTimerEvent&);
    void Lock();
    void Unlock();
    void Close();
private:
    wxTimer timer;
    SDL_Window* window = nullptr;
    SDL_Renderer* renderer = nullptr;
    SDL_Surface *surface = nullptr;
    
protected:
    wxDECLARE_EVENT_TABLE();
};

const int SDL_WINDOW_TIMER_ID = 15;

