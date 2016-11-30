#ifndef MyRect_hpp
#define MyRect_hpp

#include "SDL2/SDL.h"

class MyRect
{
public:
    SDL_Rect r;
    SDL_Color color;
    SDL_Renderer* renderer = nullptr;
    
    
    MyRect(SDL_Renderer *_renderer, int x, int y, int height, int width);
    void SetColour(int R, int G, int B, int A);
    void SetPosition(int x, int y);
    void SetPositionX(int x);
    void SetPositionY(int y);
    void SetSize(int height, int width);
    void render();
private:
    
};



#endif /* MyRect_hpp */
