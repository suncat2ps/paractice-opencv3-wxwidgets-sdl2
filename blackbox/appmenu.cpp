#include "appmenu.hpp"

AppMenuBar::AppMenuBar() {
    m_pFileMenu = new wxMenu();
    m_pFileMenu->Append(wxID_OPEN, _T("&open"));
    
    this->Append(m_pFileMenu, _T("&File"));
}
