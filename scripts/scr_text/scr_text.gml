function t_draw_text_shadowed(text, xx, yy, bold = false, color = c_white, scolor = c_grey)
{
	t_draw_text(text, xx + 2, yy + 2, bold, scolor);
	t_draw_text(text, xx, yy, bold, color);
}

function t_draw_text(text, xx, yy, bold = false, color = c_white)
{
	var loops = bold ? 2 : 1;
	var i = 0;
	repeat (loops)
	{
		draw_text_transformed_color(xx + i, yy, text, 2, 2, 0, color, color, color, color, 1);
		i++;	
	}
}