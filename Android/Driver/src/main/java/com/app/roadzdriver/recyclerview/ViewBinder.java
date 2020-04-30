package com.app.roadzdriver.recyclerview;

import androidx.recyclerview.widget.RecyclerView;


public interface ViewBinder<T>{

    public void bindViews(T obj, int position, RecyclerView recyclerView);

}
