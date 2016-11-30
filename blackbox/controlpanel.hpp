//
//  controlpanel.hpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 23..
//  Copyright © 2016년 장성각. All rights reserved.
//

#ifndef controlpanel_hpp
#define controlpanel_hpp

#include "wx/wx.h"

class wxControlPanel : public wxPanel
{
    wxButton* ok;
    wxButton* cancle;
    
    wxBoxSizer *layout;
    wxBoxSizer *line1;
    wxBoxSizer *line2;
    
    wxTextCtrl *inputFilePath;
    
    
    
public:
    wxControlPanel(wxFrame* parent);
    void OnOpen(wxCommandEvent& event);
    void OnCancle(wxCommandEvent& event);
};

#endif /* controlpanel_hpp */
