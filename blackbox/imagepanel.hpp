//
//  imagepanel.hpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 23..
//  Copyright © 2016년 장성각. All rights reserved.
//
#include "wx/wx.h"
#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#define TIMER_ID 1000

using namespace cv;

class wxImagePanel : public wxPanel
{
    wxBitmap image;
    wxTimer timer;
    VideoCapture capture;
    VideoWriter video;
    double fps = 15;
    int fourcc = CV_FOURCC('X','2','6','4'); 
    bool isColor = true;
    
    DECLARE_EVENT_TABLE()
    
public:
    wxImagePanel(wxFrame* parent);
    
    void paintEvent(wxPaintEvent & evt);
    void paintNow();
    void OnTimer( wxTimerEvent& event );
    void render(wxDC& dc);
    
};


