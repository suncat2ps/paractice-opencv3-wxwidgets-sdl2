//
//  controlpanel.cpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 23..
//  Copyright © 2016년 장성각. All rights reserved.
//

#include "controlpanel.hpp"

wxControlPanel::wxControlPanel(wxFrame *parent) : wxPanel(parent)
{
    ok = new wxButton(this, wxOK, _T("확인"));
    cancle = new wxButton(this, wxCANCEL, _T("취소"));
    
    ok->Bind(wxEVT_BUTTON, wxCommandEventHandler(wxControlPanel::OnOpen), this);
    cancle->Bind(wxEVT_BUTTON, wxCommandEventHandler(wxControlPanel::OnCancle), this);
    
    inputFilePath = new wxTextCtrl(this, -1, wxT(""));
    
    layout = new wxBoxSizer(wxVERTICAL);
    line1 = new wxBoxSizer(wxHORIZONTAL);
    line2 = new wxBoxSizer(wxHORIZONTAL);
    
    line1->Add(ok, 1, wxEXPAND);
    line1->Add(cancle, 1, wxEXPAND);
    
    line2->Add(inputFilePath, 1, wxEXPAND);
    
    layout->Add(line1, 1, wxEXPAND);
    layout->Add(line2, 1, wxEXPAND);
    
    SetSizer(layout);
}

void wxControlPanel::OnOpen(wxCommandEvent& WXUNUSED(event))
{
    wxFileDialog * openFileDialog = new wxFileDialog(this, _T("저장할 파일 선택"), _T(""), _T(""),
        _("AVI Files (*.avi)|*.avi|MP4 Files (*.mp4)|*.mp4"), wxFD_SAVE | wxFD_OVERWRITE_PROMPT, wxDefaultPosition);
    if (openFileDialog->ShowModal() == wxID_OK){
        wxString fileName = openFileDialog->GetPath();
        wxPuts(fileName);
        (*inputFilePath) << fileName;
    }
    openFileDialog->Destroy();
};

void wxControlPanel::OnCancle(wxCommandEvent& WXUNUSED(event))
{
    wxPuts(_T("Cancle"));
}

