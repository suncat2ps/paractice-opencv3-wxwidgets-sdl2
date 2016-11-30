//
//  imagepanel.cpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 23..
//  Copyright © 2016년 장성각. All rights reserved.
//

#include "imagepanel.hpp"

BEGIN_EVENT_TABLE(wxImagePanel, wxPanel)
// catch paint events
EVT_PAINT(wxImagePanel::paintEvent)

EVT_TIMER(TIMER_ID, wxImagePanel::OnTimer)
END_EVENT_TABLE()


wxImagePanel::wxImagePanel(wxFrame* parent) :
wxPanel(parent),timer(this, TIMER_ID)
{
    capture = VideoCapture(0);
    if(capture.isOpened()) {
        capture.set(CV_CAP_PROP_FRAME_WIDTH, 640);
        capture.set(CV_CAP_PROP_FRAME_HEIGHT, 480);
        
        fps = capture.get(CAP_PROP_FPS);
        
//        video.open("~/result.avi", fourcc, fps, Size(640, 480), isColor);
//        if(!video.isOpened()) {
//            return;
//        }
        
        timer.Start(1000/fps);//30 fps
    } else {
        timer.Stop();
    }
}


/*
 * Called by the system of by wxWidgets when the panel needs
 * to be redrawn. You can also trigger this call by
 * calling Refresh()/Update().
 */

void wxImagePanel::paintEvent(wxPaintEvent & evt)
{
    // depending on your system you may need to look at double-buffered dcs
    wxPaintDC dc(this);
    render(dc);
}



void wxImagePanel::OnTimer(wxTimerEvent& event)
{
    Mat frame;
    
    capture >> frame;
//    video << frame;
    
    if (frame.channels() == 3)
        cv::cvtColor(frame, frame, CV_BGR2RGB);

    wxImage tmp = wxImage(frame.cols, frame.rows, frame.data, TRUE);

    image = wxBitmap(tmp);
    paintNow();
}



/*
 * Alternatively, you can use a clientDC to paint on the panel
 * at any time. Using this generally does not free you from
 * catching paint events, since it is possible that e.g. the window
 * manager throws away your drawing when the window comes to the
 * background, and expects you will redraw it when the window comes
 * back (by sending a paint event).
 */
void wxImagePanel::paintNow()
{
    // depending on your system you may need to look at double-buffered dcs
    wxClientDC dc(this);
    render(dc);
}

/*
 * Here we do the actual rendering. I put it in a separate
 * method so that it can work no matter what type of DC
 * (e.g. wxPaintDC or wxClientDC) is used.
 */
void wxImagePanel::render(wxDC&  dc)
{
    if(image.IsOk()) {
        dc.DrawBitmap(image, 0, 0, false);
    }
}
