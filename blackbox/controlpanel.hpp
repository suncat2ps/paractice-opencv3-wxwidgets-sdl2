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
