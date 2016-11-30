#include "wx/wx.h"
#include "wx/sizer.h"
#include "wx/nativewin.h"
#include "appmenu.hpp"
#include "controlpanel.hpp"
#include "sdlframe.hpp"
#include "ObjectiveCInterface.h"
#include "imagepanel.hpp"

class MyApp : public wxApp
{
    wxFrame *frame;
    wxImagePanel * drawPane;
    wxControlPanel * ctrlPane;
    wxMenuBar *menuBar;

    public:
    virtual bool OnInit();
};
