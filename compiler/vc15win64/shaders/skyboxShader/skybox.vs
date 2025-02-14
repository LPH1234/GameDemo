#version 330 core

layout(location = 0) in vec3 position;


uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;
out vec3 TextCoord;
void main()
{
    gl_Position = projection * view * model * vec4(position, 1.0); 
    TextCoord = position;  // 当立方体中央处于原点时 立方体上位置即等价于向量
}