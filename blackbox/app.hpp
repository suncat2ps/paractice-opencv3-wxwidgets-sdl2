//
//  app.hpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 23..
//  Copyright © 2016년 장성각. All rights reserved.
//

#include "wx/wx.h"
#include "wx/sizer.h"
#include "wx/nativewin.h"
#include "imagepanel.hpp"
#include "appmenu.hpp"
#include "controlpanel.hpp"
#include "sdlframe.hpp"
#include "ObjectiveCInterface.h"

class MyApp : public wxApp
{
    wxFrame *frame;
    wxImagePanel * drawPane;
    wxControlPanel * ctrlPane;
    wxMenuBar *menuBar;

    public:
    virtual bool OnInit();
};
