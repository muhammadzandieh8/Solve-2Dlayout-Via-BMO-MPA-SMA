function haveOverlap = checkOverlap(rect1, rect2)
    % rect1 ? rect2 ?? ??? [x1, y1, width1, height1] ? [x2, y2, width2, height2] ???? ???????.

    x_overlap = max(0, min(rect1(1)+rect1(3), rect2(1)+rect2(3)) - max(rect1(1), rect2(1)));

    y_overlap = max(0, min(rect1(2)+rect1(4), rect2(2)+rect2(4)) - max(rect1(2), rect2(2)));

    haveOverlap = x_overlap > 0 && y_overlap > 0;
end
