#version 330 core

//�������ɫֵ
in float alpha;

//������ 
uniform sampler2D  texture1;

out vec4 fragColor;

void main(void)
{
    //��ʾ��ǰ���ڵ�ͼԪ�Ķ�ά�����
   // vec4 tempColor = texture2D(texture1, gl_PointCoord) * sColor;
    vec4 tempColor = texture2D(texture1, gl_PointCoord);
	//tempColor.a = tempColor.a * alpha;
	 if(tempColor.a < 0.1)
        discard;
	tempColor.w = tempColor.w * alpha;
	fragColor = tempColor;
}