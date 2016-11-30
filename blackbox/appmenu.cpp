//
//  appmenu.cpp
//  blackbox
//
//  Created by 장성각 on 2016. 11. 23..
//  Copyright © 2016년 장성각. All rights reserved.
//

#include "appmenu.hpp"

AppMenuBar::AppMenuBar() {
    m_pFileMenu = new wxMenu();
    m_pFileMenu->Append(wxID_OPEN, _T("&open"));
    
    this->Append(m_pFileMenu, _T("&File"));
}
