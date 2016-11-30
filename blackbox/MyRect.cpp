#include "MyRect.hpp"

MyRect::MyRect(SDL_Renderer *_renderer, int x, int y, int height, int width)
{
    renderer = _renderer;
    r.x = x;
    r.y = y;
    r.w = width;
    r.h = height;
    
    color.r = 255;
    color.g = 255;
    color.b = 255;
    color.a = 255;
}

void MyRect::SetColour(int R, int G, int B, int A)
{
    color.r = R;
    color.g = G;
    color.b = B;
    color.a = A;
    SDL_SetRenderDrawColor(renderer, color.r, color.g, color.b, color.a);
    render();
}

void MyRect::SetPosition(int x, int y)
{
    r.x = x;
    r.y = y;
    render();
}

void MyRect::SetPositionX(int x)
{
    r.x = x;
    render();
}

void MyRect::SetPositionY(int y)
{
    r.y = y;
    render();
}



void MyRect::SetSize(int height, int width)
{
    r.w = width;
    r.h = height;
    render();
}

void MyRect::render()
{
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    SDL_RenderFillRect( renderer, &r );
//    SDL_RenderPresent(renderer);
}
