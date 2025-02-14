#version 330 core

layout(location = 0) in vec3 position;


uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

uniform float  dy;
uniform float  maxY;
uniform float  pointSize;
uniform float  radis;
uniform float  alpha1;
uniform vec3  initPos;

out float alpha;

void main(void)
{
    //传递顶点
    vec3 vNewPosition = position;
	alpha = 1.0;

	float dist = sqrt((position.x - initPos.x)*(position.x - initPos.x) + (position.z - initPos.z)*(position.z - initPos.z));
	if(dist > radis) {
		vNewPosition.x = initPos.x;
		vNewPosition.z = initPos.z;
		dist = radis/10.0;
	}
	if(dist < radis/10) dist = radis/10;
	float dyFactor = (1 - dist/(1.5*radis));
	if(dyFactor <= 0)
		dyFactor = 0.1;
	float new_dy = dy * dyFactor;
	float yFactor = (1 - dist/(1.1*radis));
	if(yFactor <= 0)
		yFactor = 0.1;
	float new_maxY = maxY * yFactor;
    if(new_dy > new_maxY){
		new_dy -= floor(new_dy/new_maxY) * new_maxY;
	}

	vNewPosition.y += new_dy; //设置新的位置的y值要加上new_dy

    //设置点的大小，高度越高，越小
	gl_PointSize = pointSize * (1 - new_dy/new_maxY);

		
    // If they are very small, fade them up
    //判断如果粒子太小了，就会发生闪烁，所以我们要去使这个点的颜色逐渐变暗，从而使它们在视野中消失。
	float fade_size = 4.0;
    if(gl_PointSize < fade_size)
        alpha = smoothstep(0.0, fade_size, gl_PointSize);
	alpha = alpha * alpha1;
    gl_Position = projection * view * model * vec4(vNewPosition, 1.0); 
}